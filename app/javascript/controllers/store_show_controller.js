// app/javascript/controllers/store-show.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["adminList", "publicList"]

  connect() {
    // Show the admin list by default
    console.log("store-show controller connected")
    this.showAdminList()
  }

  showAdminList() {
    this.adminListTarget.style.display = "block"
    this.publicListTarget.style.display = "none"
    // Add "active" class to the Admin button
    this.element.querySelector("[data-action='click->store-show#showAdminList']").classList.add("active");
    // Remove "active" class from the Preview button
    this.element.querySelector("[data-action='click->store-show#showPublicList']").classList.remove("active");
  }

  showPublicList() {
    this.adminListTarget.style.display = "none"
    this.publicListTarget.style.display = "block"
    // Add "active" class to the Preview button
    this.element.querySelector("[data-action='click->store-show#showPublicList']").classList.add("active");
    // Remove "active" class from the Admin button
    this.element.querySelector("[data-action='click->store-show#showAdminList']").classList.remove("active");
  }
}
