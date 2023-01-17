import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-css-class"
export default class extends Controller {
  static targets = ["element"]
  static values = { cssClass: String }

  connect() {
    console.log(this.elementTarget);
    console.log(this.cssClassValue);

    setInterval(() => {
      this.elementTarget.classList.remove(this.cssClassValue)
    }, 3000);
  }
}
