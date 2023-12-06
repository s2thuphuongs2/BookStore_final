package tdtu.bookstore.config;

import java.io.IOException;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tdtu.bookstore.customenum.RoleEnum;
import tdtu.bookstore.dto.auth.UserAuthentication;
import tdtu.bookstore.dto.auth.output.LoginOutput;
import tdtu.bookstore.util.AuthUtil;


@Component
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	@Autowired
	private ObjectMapper objectMapper;

	@Value("${app.secret-key}")
	private String secretKey;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {

		CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

		if (userDetails.getUser().getRole().equals(RoleEnum.ADMIN)) {
			response.sendRedirect("/admin/books");
			return;
		}

		// Thêm token vào header của response
//		addTokenToResponse(response, userDetails);

		response.sendRedirect(request.getContextPath());
	}

	private void addTokenToResponse(HttpServletResponse response, CustomUserDetails userDetails) {
		// Tạo đối tượng UserAuthentication từ thông tin người dùng
		UserAuthentication userAuthentication = new UserAuthentication();
		userAuthentication.setUserId(userDetails.getUser().getId());
		userAuthentication.setRole(userDetails.getUser().getRole());

		// Chuyển đối tượng thành Map để tạo payload cho JWT
		Map<String, Object> payload = objectMapper.convertValue(userAuthentication, new TypeReference<>() {});

		// Tạo đối tượng LoginOutput để chứa token
		LoginOutput output = new LoginOutput();
		output.setUserId(userDetails.getUser().getId());
		output.setToken(AuthUtil.generateToken(payload, secretKey));

		// Thêm token vào header của response
		response.setHeader(HttpHeaders.AUTHORIZATION, "Bearer " + output.getToken());
	}


}

