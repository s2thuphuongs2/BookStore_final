package tdtu.bookstore.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.model.Publisher;
import tdtu.bookstore.repository.PublisherRepository;

@Controller
public class PublisherController {

	@Autowired
	PublisherRepository publisherRepository;

	@GetMapping("/admin/publishers")
	public ModelAndView viewPublisher() {
		ModelAndView modelAndView = new ModelAndView("admin/publisher/index");
		List<Publisher> publishers = publisherRepository.findAll();

		modelAndView.addObject("publishers", publishers);

		return modelAndView;
	}

	@PostMapping("/admin/publishers")
	public ModelAndView addPublisher(@RequestParam(value = "publisherName", required = false) String publisherName) {

		Publisher publisher = new Publisher();

		if (publisherName != null)
			publisher.setName(publisherName);

		publisherRepository.save(publisher);

		return new ModelAndView("redirect:/admin/publishers");
	}

	@PostMapping("/admin/publishers/{publisherId}/edit")
	public ModelAndView editPublisher(@RequestParam(value = "publisherName", required = false) String publisherName,
			@PathVariable(required = true, name = "publisherId") Integer publisherid) {

		Publisher publisher = publisherRepository.findById(publisherid).get();

		if (publisherName != null)
			publisher.setName(publisherName);

		publisherRepository.save(publisher);

		return new ModelAndView("redirect:/admin/publishers");
	}

	@PostMapping("/admin/publishers/{publisherId}/delete")
	public ModelAndView deletePublisher(@PathVariable(required = true, name = "publisherId") Integer publisherid) {

		publisherRepository.deleteById(publisherid);

		return new ModelAndView("redirect:/admin/publishers");
	}
}
