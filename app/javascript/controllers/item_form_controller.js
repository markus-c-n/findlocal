// app/javascript/controllers/item-form-controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["mainCategory", "subCategory"];

  connect() {
    this.updateSubCategories(); // Initialize sub-category options
  }

  updateSubCategories() {
    const mainCategoryId = this.mainCategoryTarget.value;

    if (mainCategoryId) {
      fetch(`/categories/${mainCategoryId}/sub_categories`)
        .then(response => response.json())
        .then(data => {
          this.subCategoryTarget.innerHTML = data.options;
        });
    } else {
      this.subCategoryTarget.innerHTML = '<option value="">Select Sub-category</option>';
    }
  }
}
