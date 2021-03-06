package com.hk.frame.web.action;

import com.hk.frame.web.http.HkRequest;
import com.hk.frame.web.http.HkResponse;

/**
 * 所有控制器类型需要实现此接口，默认执行接口的execute方法，例如http://localhost:8080/appctx/hello，
 * 就是执行HelloAction的execute方法 如果要执行其他方法，则只需要写method(HkRequest req, HkResponse
 * resp) throws
 * Exception;，例如http://localhost:8080/appctx/hello_test，就是执行HelloAction中的test
 * (HkRequest req, HkResponse resp)方法
 * 
 * @author akwei
 */
public interface Action {

	String execute(HkRequest req, HkResponse resp) throws Exception;
}