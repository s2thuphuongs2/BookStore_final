package tdtu.bookstore.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.model.Bill;
import tdtu.bookstore.model.Book;
import tdtu.bookstore.model.Cart;
import tdtu.bookstore.model.Publisher;
import tdtu.bookstore.repository.BillRepository;
import tdtu.bookstore.repository.BookRepository;
import tdtu.bookstore.repository.CartRepository;
import tdtu.bookstore.repository.PublisherRepository;

@Controller
public class CartController {

	@Autowired
	CartRepository cartRepository;

	@Autowired
	BookRepository bookRepository;

	@Autowired
	BillRepository billRepository;

	@GetMapping("/carts/{userid}")
	@ResponseBody
	public List<Cart> getCart(@PathVariable(required = true, name = "userid") Integer userid) {
		List<Cart> carts = cartRepository.findAllByUserId(userid);
		return carts;
	}

	@PostMapping("/carts/{userid}")
	@ResponseBody
	public String addCart(@PathVariable(required = true, name = "userid") Integer userid,
			@RequestParam(required = true, name = "bookid") Integer bookid,
			@RequestParam(required = true, name = "quantity") Integer quantity) {

		Cart cart = cartRepository.findAllByUserIdAndBookid(userid, bookid);
		if (cart == null) {
			cart = new Cart();

			cart.setUserid(userid);
			cart.setBookid(bookid);
			cart.setQuantity(quantity);

		} else {
			cart.setQuantity(cart.getQuantity() + quantity);
		}

		cartRepository.save(cart);

		Integer cartcount = 0;

		for (Cart cartIter : cartRepository.findAllByUserId(userid)) {
			cartcount += cartIter.getQuantity();
		}

		return "add_success:" + cartcount;
	}

	@PostMapping("/carts/{userid}/{bookid}")
	@ResponseBody
	public String editCart(@PathVariable(required = true, name = "userid") Integer userid,
			@PathVariable(required = true, name = "bookid") Integer bookid,
			@RequestParam(required = true, name = "quantity") Integer quantity) {

		Cart cart = cartRepository.findAllByUserIdAndBookid(userid, bookid);

		cart.setQuantity(quantity);

		cartRepository.save(cart);

		Integer cartcount = 0;
		Integer sum = 0;

		List<Cart> carts = cartRepository.findAllByUserId(userid);

		List<Integer> bookids = new ArrayList<Integer>();
		
		for (Cart cartIter : carts) {
			bookids.add(cartIter.getBookid());
			cartcount += cartIter.getQuantity();
		}

		List<Book> books = bookRepository.findAllById(bookids);
	
		
		for (int i = 0; i < carts.size(); i++) {
			sum += carts.get(i).getQuantity() * books.get(i).getPrice();
		}

		return "edit_success:" + cartcount + ":" + sum;
	}

	@PostMapping("/carts/{userid}/{bookid}/delete")
	@ResponseBody
	public String deleteCart(@PathVariable(required = true, name = "userid") Integer userid,
			@PathVariable(required = true, name = "bookid") Integer bookid) {

		Cart cart = cartRepository.findAllByUserIdAndBookid(userid, bookid);

		if (cart != null) {
			cartRepository.delete(cart);
		}

		Integer cartcount = 0;
		Integer sum = 0;

		List<Cart> carts = cartRepository.findAllByUserId(userid);

		List<Integer> bookids = new ArrayList<Integer>();

		for (Cart cartIter : carts) {
			bookids.add(cartIter.getBookid());
			cartcount += cartIter.getQuantity();
		}

		List<Book> books = bookRepository.findAllById(bookids);

		for (int i = 0; i < carts.size(); i++) {
			sum += carts.get(i).getQuantity() * books.get(i).getPrice();
		}

		return "remove_success:" + cartcount + ":sum";
	}

	@PostMapping("/carts/{userid}/checkout")
	@ResponseBody
	public String checkoutCart(@PathVariable(required = true, name = "userid") Integer userid,
			@RequestParam(required = true, name = "phone") String phone,
			@RequestParam(required = true, name = "address") String address) {

		List<Cart> carts = cartRepository.findAllByUserId(userid);

		Integer sum = 0;

		List<String> bookquantities = new ArrayList<String>();
		List<Integer> bookids = new ArrayList<Integer>();
		for (Cart cartIter : carts) {
			bookquantities.add(cartIter.getBookid() + ":" + cartIter.getQuantity());
			bookids.add(cartIter.getBookid());
		}
		String cartstring = String.join(",", bookquantities);

		List<Book> books = bookRepository.findAllById(bookids);

		for (int i = 0; i < carts.size(); i++) {
			sum += carts.get(i).getQuantity() * books.get(i).getPrice();
		}

		Bill bill = new Bill();
		bill.setCarts(cartstring);
		bill.setTotal(sum);
		bill.setUserid(userid);
		bill.setAddress(address);
		bill.setPhone(phone);
		billRepository.save(bill);

		cartRepository.deleteAll(carts);

		return "checkout_success:";
	}
}
