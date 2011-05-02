package cactus.web.util;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cactus.web.action.HkRequest;
import cactus.web.action.HkRequestImpl;
import cactus.web.action.HkResponse;
import cactus.web.action.HkResponseImpl;

public class HkWebUtil {

	public static HkRequest getHkRequest(HttpServletRequest request)
			throws IOException {
		return new HkRequestImpl(request);
	}

	public static HkResponse getHkResponse(HttpServletResponse response) {
		return new HkResponseImpl(response);
	}
}