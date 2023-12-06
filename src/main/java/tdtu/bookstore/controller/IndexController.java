package tdtu.bookstore.controller;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import tdtu.bookstore.model.Author;
import tdtu.bookstore.model.Bill;
import tdtu.bookstore.model.Book;
import tdtu.bookstore.model.Cart;
import tdtu.bookstore.model.Category;
import tdtu.bookstore.model.Publisher;
import tdtu.bookstore.model.User;
import tdtu.bookstore.repository.AuthorRepository;
import tdtu.bookstore.repository.BillRepository;
import tdtu.bookstore.repository.BookRepository;
import tdtu.bookstore.repository.CartRepository;
import tdtu.bookstore.repository.CategoryRepository;
import tdtu.bookstore.repository.PublisherRepository;
import tdtu.bookstore.repository.UserRepository;
import tdtu.bookstore.config.CustomUserDetails;
import tdtu.bookstore.service.AuthService;

@Controller
public class IndexController {
	@Autowired
	private BookRepository bookRepository;

	@Autowired
	private AuthorRepository authorRepository;

	@Autowired
	private PublisherRepository publisherRepository;

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private CartRepository cartRepository;
	
	@Autowired
	private BillRepository billRepository;

	@Autowired
	private AuthService authService;
	@GetMapping("/")
	public ModelAndView index() {
		ModelAndView modelAndView = new ModelAndView("index");
		setHeader(modelAndView);

		List<Book> latestbooks = bookRepository.getLatestBooks();
		List<Book> randbooks = bookRepository.getRandomBooks();

		modelAndView.addObject("latestbooks", latestbooks);
		modelAndView.addObject("randbooks", randbooks);

		return modelAndView;
	}

	@GetMapping("/search")
	public ModelAndView search(@RequestParam(required = false) String q) {
		if (q == null) {
			return new ModelAndView("redirect:/");
		}

		if (q.isEmpty()) {
			return new ModelAndView("redirect:/");
		}

		ModelAndView modelAndView = new ModelAndView("search");
		setHeader(modelAndView);

		List<Book> books = new ArrayList<Book>();
		String[] qs = q.split(" ");
		for (String query : qs) {
			List<Book> tmp = bookRepository.findByName(query);
			for (Book book : tmp) {
				if (!books.contains(book)) {
					books.add(book);
				}
			}
		}

		modelAndView.addObject("books", books);
		modelAndView.addObject("query", q);

		return modelAndView;
	}

	@GetMapping(path = "book/{bookId}")
	public ModelAndView bookView(@PathVariable(required = true, name = "bookId") Integer bookId) {
		ModelAndView modelAndView = new ModelAndView("book-detail");
		setHeader(modelAndView);

		Book book = bookRepository.findById(bookId).get();
		Author author = authorRepository.findById(book.getAuthorid()).get();
		Publisher publisher = publisherRepository.findById(book.getPublisherid()).get();

		if (book.getCategory() != null) {
			int[] categoryIdsInt = Stream.of(book.getCategory().split(",")).mapToInt(Integer::parseInt).toArray();
			List<Integer> categoryIds = Arrays.stream(categoryIdsInt).boxed().toList();
			List<Category> categories = categoryRepository.findAllById(categoryIds);
			modelAndView.addObject("bookCategories", categories);
		}

		modelAndView.addObject(book);
		modelAndView.addObject(author);
		modelAndView.addObject(publisher);

		return modelAndView;
	}

	@GetMapping(path = "category/{categoryId}")
	public ModelAndView categoryView(@PathVariable(required = true, name = "categoryId") Integer categoryId) {
		ModelAndView modelAndView = new ModelAndView("category");
		setHeader(modelAndView);

		Category category = categoryRepository.findById(categoryId).get();
		List<Book> books = bookRepository.findByCategory(categoryId + "");

		modelAndView.addObject("books", books);
		modelAndView.addObject("category", category);

		return modelAndView;
	}

	@GetMapping(path = "author/{authorid}")
	public ModelAndView authorView(@PathVariable(required = true, name = "authorid") Integer authorid) {
		ModelAndView modelAndView = new ModelAndView("author");
		setHeader(modelAndView);

		Author author = authorRepository.findById(authorid).get();
		List<Book> books = bookRepository.findByAuthor(authorid + "");

		modelAndView.addObject("books", books);
		modelAndView.addObject("author", author);

		return modelAndView;
	}

	@GetMapping(path = "publisher/{publisherid}")
	public ModelAndView publisherView(@PathVariable(required = true, name = "publisherid") Integer publisherid) {
		ModelAndView modelAndView = new ModelAndView("publisher");
		setHeader(modelAndView);

		Publisher publisher = publisherRepository.findById(publisherid).get();
		List<Book> books = bookRepository.findByPublisher(publisherid + "");

		modelAndView.addObject("books", books);
		modelAndView.addObject("publisher", publisher);

		return modelAndView;
	}
//TODO: sua lai register
	@GetMapping("/register")
	public ModelAndView registeregister() {
		return new ModelAndView("register");
	}

	@GetMapping("/login")
	public ModelAndView login() {
		return new ModelAndView("login");
	}

	@PostMapping("/login")
	@ResponseBody
	public String login(@RequestParam(value = "username") String username,
						@RequestParam(value = "password") String password) {
		User user = new User();
		user.setUsername(username);
		user.setPassword(password); // TODO: AuthUtil encoded password

		return authService.login(user);// "login_success"; //use in login.jsp
	}

	@PostMapping("/register")
	@ResponseBody
	public String processRegister(@RequestParam(value = "username") String username,
										@RequestParam(value = "password") String password, @RequestParam(value = "phone") String phone) {
		User user = new User();
		user.setUsername(username);
		user.setPhone(phone);
		user.setPassword(password); // TODO: AuthUtil encoded password

//		userRepository.save(user);

		return authService.signUp(user);// "register_success"; //use in register.jsp
	}
	
	@GetMapping("/checkout")
	public ModelAndView checkout() {
		ModelAndView modelAndView = new ModelAndView("checkout");
		setHeader(modelAndView);
		
		Integer userid = ((CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUser().getId();
		List<Cart> carts = cartRepository.findAllByUserId(userid);
		List<Integer> bookids = new ArrayList<Integer>();
		
		for (Cart cart: carts) {
			bookids.add(cart.getBookid());
		}
		
		List<Book> books = bookRepository.findAllById(bookids);

		for (int i = 0; i < books.size(); i++) {
			books.get(i).setQuantity(carts.get(i).getQuantity());
		}
		
		modelAndView.addObject("books", books);
		
		return modelAndView;
	}

	public void setHeader(ModelAndView modelAndView) {
		List<Category> categories = categoryRepository.getRandomCategories();
		modelAndView.addObject("categories", categories);
		Object user = (Object) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		String username = "";
		Integer cartcount = 0;
		
		if (user.toString() != "anonymousUser") {
			Integer userid = ((CustomUserDetails ) user).getUser().getId();
			String phone = ((CustomUserDetails ) user).getUser().getPhone();
			Integer sum = 0;
			
			List<Integer> bookids = new ArrayList<Integer>();
			List<Cart> carts = cartRepository.findAllByUserId(userid);
			for (Cart cart: carts) {
				cartcount += cart.getQuantity();
				bookids.add(cart.getBookid());
			}
			
			List<Book> books = bookRepository.findAllById(bookids);
			
			for (int i = 0; i < carts.size(); i ++) {
				sum += carts.get(i).getQuantity() * books.get(i).getPrice();
			}
			
			username = ((CustomUserDetails ) user).getUsername();
			
			modelAndView.addObject("userid", userid);
			modelAndView.addObject("phone", phone);
			
			modelAndView.addObject("totalprice", NumberFormat.getNumberInstance(Locale.US).format(sum));
		} 
		
		
		modelAndView.addObject("username", username);
		modelAndView.addObject("cartcount", cartcount);
	}
	
	@GetMapping("/bills")
	public ModelAndView viewBill() {
		ModelAndView modelAndView = new ModelAndView("bill");
		setHeader(modelAndView);
		
		Integer userid = ((CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUser().getId();
		List<Bill> bills = billRepository.findAllByUserId(userid);
		Collections.reverse(bills);
		modelAndView.addObject("bills", bills);
		modelAndView.addObject("userRepository", userRepository);

		return modelAndView;
	}
	
	@PostMapping("/bills/{billid}/cancel")
	@ResponseBody
	public String cancelBill(@PathVariable(required = true, value = "billid") Integer billid) {
		Bill bill = billRepository.findById(billid).get();
		bill.setStatus(-1);
		billRepository.save(bill);

		return "cancel_success";
	}
	
	@GetMapping("/bills/{billid}")
	@ResponseBody
	public ModelAndView getBillDetail(@PathVariable(required = true, value = "billid") Integer billid) {
		ModelAndView modelAndView = new ModelAndView("bill-detail");
		

		Bill bill = billRepository.findById(billid).get();
		List<Book> books = new ArrayList<Book>();

		String[] bookquantities = bill.getCarts().split(",");

		for (String bookquantity : bookquantities) {
			String[] bookidquantity = bookquantity.split(":");
			Book book = bookRepository.findById(Integer.parseInt(bookidquantity[0])).get();
			book.setQuantity(Integer.parseInt(bookidquantity[1]));
			books.add(book);
		}

		modelAndView.addObject("books", books);
		modelAndView.addObject("bill", bill);
		return modelAndView;
	}
}
