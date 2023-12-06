package tdtu.bookstore.service;


import tdtu.bookstore.model.User;

public interface AuthService {
    String login(User input);
    String signUp(User input);
}
