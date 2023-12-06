package tdtu.bookstore.controller;

import java.util.ArrayList;
import java.util.Collections;
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
import tdtu.bookstore.model.Publisher;
import tdtu.bookstore.repository.BillRepository;
import tdtu.bookstore.repository.BookRepository;
import tdtu.bookstore.repository.PublisherRepository;
import tdtu.bookstore.repository.UserRepository;

@Controller
public class BillController {

	@Autowired
	BillRepository billRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	BookRepository bookRepository;

	@GetMapping("/admin/bills")
	public ModelAndView viewBill() {
		ModelAndView modelAndView = new ModelAndView("admin/bill/index");
		List<Bill> bills = billRepository.findAll();
		Collections.reverse(bills);
		
		modelAndView.addObject("bills", bills);
		modelAndView.addObject("userRepository", userRepository);

		return modelAndView;
	}
	
	@PostMapping("/admin/bills/{billid}/done")
	@ResponseBody
	public String doneBill(@PathVariable(required = true, value = "billid") Integer billid) {
		Bill bill = billRepository.findById(billid).get();
		bill.setStatus(1);
		billRepository.save(bill);

		return "done_success";
	}
	
	@PostMapping("/admin/bills/{billid}/cancel")
	@ResponseBody
	public String cancelBill(@PathVariable(required = true, value = "billid") Integer billid) {
		Bill bill = billRepository.findById(billid).get();
		bill.setStatus(-1);
		billRepository.save(bill);

		return "cancel_success";
	}
	

	@GetMapping("/admin/bills/{billid}")
	@ResponseBody
	public ModelAndView getBillDetail(@PathVariable(required = true, value = "billid") Integer billid) {
		ModelAndView modelAndView = new ModelAndView("admin/bill/detail");


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
