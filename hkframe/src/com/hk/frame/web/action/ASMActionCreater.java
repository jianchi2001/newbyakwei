package com.hk.frame.web.action;

import org.objectweb.asm.ClassWriter;
import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.Opcodes;
import org.objectweb.asm.Type;
import org.springframework.jdbc.core.RowMapper;

/**
 * 动态生成Action类的子类
 * 
 * @author akwei
 */
public class ASMActionCreater extends ClassLoader implements Opcodes {

	public ASMActionCreater(ClassLoader parent) {
		super(parent);
	}

	@SuppressWarnings("unchecked")
	public <T> Class<T> createASMAction(ActionMapping actionMapping) {
		ClassWriter classWriter = new ClassWriter(0);
		String actionName = createMapperClassName(actionMapping);
		String actionClassName = actionName.replaceAll("\\.", "/");
		classWriter.visit(V1_5, ACC_PUBLIC, actionClassName, null,
				"java/lang/Object", new String[] { Type
						.getInternalName(Action.class) });
		// action字段
		classWriter.visitField(ACC_PRIVATE, "action",
				Type.getDescriptor(actionMapping.getAction().getClass()), null,
				null).visitEnd();
		// 构造方法
		MethodVisitor methodVisitor = classWriter.visitMethod(ACC_PUBLIC,
				"<init>", "()V", null, null);
		methodVisitor.visitMaxs(1, 1);
		methodVisitor.visitVarInsn(ALOAD, 0);
		methodVisitor.visitMethodInsn(INVOKESPECIAL, "java/lang/Object",
				"<init>", "()V");
		methodVisitor.visitInsn(RETURN);
		methodVisitor.visitEnd();
		// execute 方法
		methodVisitor = classWriter
				.visitMethod(
						ACC_PUBLIC,
						"execute",
						"(Lcom/hk/frame/web/http/HkRequest;Lcom/hk/frame/web/http/HkResponse;)Ljava/lang/String;",
						null, new String[] { Type
								.getInternalName(Exception.class) });
		methodVisitor.visitMaxs(3, 3);
		methodVisitor.visitVarInsn(ALOAD, 0);
		methodVisitor.visitFieldInsn(GETFIELD, actionClassName, "action", Type
				.getDescriptor(actionMapping.getAction().getClass()));
		methodVisitor.visitVarInsn(ALOAD, 1);
		methodVisitor.visitVarInsn(ALOAD, 2);
		String methodDesc = Type.getMethodDescriptor(actionMapping
				.getActionMethod());
		methodVisitor.visitMethodInsn(INVOKEVIRTUAL, Type
				.getInternalName(actionMapping.getAction().getClass()),
				actionMapping.getMethodName(), methodDesc);
		methodVisitor.visitInsn(ARETURN);
		methodVisitor.visitEnd();
		// 生成action class
		byte[] code = classWriter.toByteArray();
		try {
			this.loadClass(RowMapper.class.getName());
			Class<T> mapperClass = (Class<T>) this.defineClass(actionName,
					code, 0, code.length);
			return mapperClass;
		}
		catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private String createMapperClassName(ActionMapping actionMapping) {
		int idx = actionMapping.getAction().getClass().getName().lastIndexOf(
				".");
		String shortName = actionMapping.getAction().getClass().getName()
				.substring(idx + 1);
		String pkgName = actionMapping.getAction().getClass().getName()
				.substring(0, idx);
		return pkgName + "." + shortName + "Method"
				+ actionMapping.getMethodName() + "ASMAction";
	}
}
