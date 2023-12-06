package tdtu.bookstore.controller;

import java.io.IOException;
import java.util.Base64;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.model.Author;
import tdtu.bookstore.model.Book;
import tdtu.bookstore.model.Category;
import tdtu.bookstore.model.Publisher;
import tdtu.bookstore.repository.AuthorRepository;
import tdtu.bookstore.repository.BookRepository;
import tdtu.bookstore.repository.CategoryRepository;
import tdtu.bookstore.repository.PublisherRepository;

@Controller
public class BookController {
	@Autowired
	BookRepository bookRepository;

	@Autowired
	AuthorRepository authorRepository;

	@Autowired
	PublisherRepository publisherRepository;

	@Autowired
	CategoryRepository categoryRepository;

	@GetMapping("/admin/books")
	public ModelAndView viewBook() {
		ModelAndView modelAndView = new ModelAndView("admin/book/index");
		List<Category> categories = categoryRepository.findAll();
		List<Author> authors = authorRepository.findAll();
		List<Publisher> publishers = publisherRepository.findAll();
		List<Book> books = bookRepository.findAll();
		
		modelAndView.addObject("categories", categories);
		modelAndView.addObject("publishers", publishers);
		modelAndView.addObject("authors", authors);
		modelAndView.addObject("books", books);
		
		
		return modelAndView;
	}
	
	@GetMapping("/admin/books/{bookId}")
	@ResponseBody
	public Book getBook(@PathVariable(required = true, name = "bookId") Integer bookid) {
		Book book = bookRepository.findById(bookid).get();
		book.setImage("");
		book.setQuantity(0);
		
		
		return book;
	}
	
	@PostMapping("/admin/books")
	public ModelAndView addBook(@RequestParam(value = "bookCate", required = false) List<String> bookCate,
			@RequestParam(value = "bookPrice", required = false) Integer bookPrice,
			@RequestParam(value = "bookPage", required = false) Integer bookPage,
			@RequestParam(value = "bookAuthor", required = false) Integer bookAuthor,
			@RequestParam(value = "bookPubl", required = false) Integer bookPubl,
			@RequestParam(value = "bookSize", required = false) String bookSize,
			@RequestParam(value = "bookDesc", required = false) String bookDesc,
			@RequestParam(value = "bookName", required = false) String bookName,
			@RequestParam(value = "bookImage", required = false) MultipartFile bookImage) {

		Book book = new Book();

		if (bookImage != null) {
			try {
				byte[] bytes = bookImage.getBytes();
				byte[] encoded = Base64.getEncoder().encode(bytes);

				book.setImage(new String(encoded));
			} catch (IOException e) {

				e.printStackTrace();
			}
		}

		if (bookPrice != null)
			book.setPrice(bookPrice);

		if (bookPage != null)
			book.setPage(bookPage);

		if (bookSize != null)
			book.setSize(bookSize);

		if (bookDesc != null)
			book.setDescription(bookDesc);

		if (bookName != null)
			book.setName(bookName);

		if (bookCate != null)
			book.setCategory(String.join(",", bookCate));
		
		if (bookAuthor != null)
			book.setAuthorid(bookAuthor);
		
		if (bookPubl != null)
			book.setPublisherid(bookPubl);
		
		bookRepository.save(book);

		return new ModelAndView("redirect:/admin/books");
	}
	
	@PostMapping("/admin/books/{bookid}/edit")
	public ModelAndView editBook(@RequestParam(value = "bookCate", required = false) List<String> bookCate,
			@RequestParam(value = "bookPrice", required = false) Integer bookPrice,
			@RequestParam(value = "bookPage", required = false) Integer bookPage,
			@RequestParam(value = "bookAuthor", required = false) Integer bookAuthor,
			@RequestParam(value = "bookPubl", required = false) Integer bookPubl,
			@RequestParam(value = "bookSize", required = false) String bookSize,
			@RequestParam(value = "bookDesc", required = false) String bookDesc,
			@RequestParam(value = "bookName", required = false) String bookName,
			@RequestParam(value = "bookImage", required = false) MultipartFile bookImage,
			@PathVariable(value = "bookid", required = true) Integer bookid) {

		Book book = bookRepository.findById(bookid).get();
		System.out.println(book);
		if (!bookImage.isEmpty()) {
			try {
				byte[] bytes = bookImage.getBytes();
				byte[] encoded = Base64.getEncoder().encode(bytes);

				book.setImage(new String(encoded));
			} catch (IOException e) {

				e.printStackTrace();
			}
		}

		if (bookPrice != null)
			book.setPrice(bookPrice);

		if (bookPage != null)
			book.setPage(bookPage);

		if (bookSize != null)
			book.setSize(bookSize);

		if (bookDesc != null)
			book.setDescription(bookDesc);

		if (bookName != null)
			book.setName(bookName);

		if (bookCate != null)
			book.setCategory(String.join(",", bookCate));
		else
			book.setCategory("");
		
		if (bookAuthor != null)
			book.setAuthorid(bookAuthor);
		
		if (bookPubl != null)
			book.setPublisherid(bookPubl);
		
		bookRepository.save(book);

		return new ModelAndView("redirect:/admin/books");
	}
	
	@PostMapping("/admin/books/{bookid}/delete")
	public ModelAndView deleteAuthor(@PathVariable(required = true, name = "bookid") Integer bookid) {

		bookRepository.deleteById(bookid);

		return new ModelAndView("redirect:/admin/books");
	}
}
