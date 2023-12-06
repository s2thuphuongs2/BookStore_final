package tdtu.bookstore.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.model.Author;
import tdtu.bookstore.repository.AuthorRepository;

@Controller
public class AuthorController {

	@Autowired
	AuthorRepository authorRepository;

	@GetMapping("/admin/authors")
	public ModelAndView viewAuthor() {
		ModelAndView modelAndView = new ModelAndView("admin/author/index");
		List<Author> authors = authorRepository.findAll();

		modelAndView.addObject("authors", authors);

		return modelAndView;
	}

	@PostMapping("/admin/authors")
	public ModelAndView addAuthor(@RequestParam(value = "authorName", required = false) String authorName) {

		Author author = new Author();

		if (authorName != null)
			author.setName(authorName);

		authorRepository.save(author);

		return new ModelAndView("redirect:/admin/authors");
	}

	@PostMapping("/admin/authors/{authorId}/edit")
	public ModelAndView editAuthor(@RequestParam(value = "authorName", required = false) String authorName,
			@PathVariable(required = true, name = "authorId") Integer authorid) {

		Author author = authorRepository.findById(authorid).get();

		if (authorName != null)
			author.setName(authorName);

		authorRepository.save(author);

		return new ModelAndView("redirect:/admin/authors");
	}

	@PostMapping("/admin/authors/{authorId}/delete")
	public ModelAndView deleteAuthor(@PathVariable(required = true, name = "authorId") Integer authorid) {

		authorRepository.deleteById(authorid);

		return new ModelAndView("redirect:/admin/authors");
	}
}
