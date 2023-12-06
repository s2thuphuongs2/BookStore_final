package tdtu.bookstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.repository.AuthorRepository;
import tdtu.bookstore.repository.BookRepository;
import tdtu.bookstore.repository.CategoryRepository;
import tdtu.bookstore.repository.PublisherRepository;

@Controller
public class AdminController {
	@Autowired
	BookRepository bookRepository;

	@Autowired
	AuthorRepository authorRepository;

	@Autowired
	PublisherRepository publisherRepository;

	@Autowired
	CategoryRepository categoryRepository;

	@GetMapping("/admin")
	public ModelAndView index() {
		ModelAndView modelAndView = new ModelAndView("redirect:/admin/books");

		return modelAndView;
	}
}
