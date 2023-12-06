package tdtu.bookstore.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tdtu.bookstore.model.Category;
import tdtu.bookstore.repository.CategoryRepository;

@Controller
public class CategoryController {

	@Autowired
	CategoryRepository categoryRepository;

	@GetMapping("/admin/categories")
	public ModelAndView viewCategory() {
		ModelAndView modelAndView = new ModelAndView("admin/category/index");
		List<Category> categories = categoryRepository.findAll();

		modelAndView.addObject("categories", categories);

		return modelAndView;
	}

	@PostMapping("/admin/categories")
	public ModelAndView addCategory(@RequestParam(value = "categoryName", required = false) String categoryName) {

		Category category = new Category();

		if (categoryName != null)
			category.setName(categoryName);

		categoryRepository.save(category);

		return new ModelAndView("redirect:/admin/categories");
	}

	@PostMapping("/admin/categories/{categoryId}/edit")
	public ModelAndView editCategory(@RequestParam(value = "categoryName", required = false) String categoryName,
			@PathVariable(required = true, name = "categoryId") Integer categoryid) {

		Category category = categoryRepository.findById(categoryid).get();

		if (categoryName != null)
			category.setName(categoryName);

		categoryRepository.save(category);

		return new ModelAndView("redirect:/admin/categories");
	}

	@PostMapping("/admin/categories/{categoryId}/delete")
	public ModelAndView deleteCategory(@PathVariable(required = true, name = "categoryId") Integer categoryid) {

		categoryRepository.deleteById(categoryid);

		return new ModelAndView("redirect:/admin/categories");
	}
}
