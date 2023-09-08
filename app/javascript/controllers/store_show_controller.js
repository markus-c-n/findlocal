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
  }

  showPublicList() {
    this.adminListTarget.style.display = "none"
    this.publicListTarget.style.display = "block"
  }
}
