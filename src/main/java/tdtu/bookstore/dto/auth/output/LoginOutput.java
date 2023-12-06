package tdtu.bookstore.dto.auth.output;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class LoginOutput implements Serializable {
	private static final long serialVersionUID = -6836438257033536332L;
	private Integer userId;
	private String token;
}
