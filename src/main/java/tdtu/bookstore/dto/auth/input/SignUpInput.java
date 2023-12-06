package tdtu.bookstore.dto.auth.input;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Getter
@Setter
public class SignUpInput {
    private String username;
    private String password;
    private String phone;
}
