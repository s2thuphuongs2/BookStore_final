package tdtu.bookstore.mapper;

//import tdtu.bookstore.dto.account.output.GetPersonalInfoOutput;
import tdtu.bookstore.dto.auth.input.SignUpInput;
import tdtu.bookstore.model.User;
import tdtu.bookstore.util.AuthUtil;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(imports = AuthUtil.class)
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    @Mapping(target = "password", expression = "java(AuthUtil.hashPassword(input.getPassword()))")
    User mapFromSignUpInput(User input);


//    GetPersonalInfoOutput mapToPersonalInfoOutput(UserEntity input);
}
