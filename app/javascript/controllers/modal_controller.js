import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['content']
  static classes = ['hidden']

  connect() {
    this.element.openModal = this.open.bind(this);
    this.element.closeModal = this.close.bind(this);
    this.isOpen = !this.element.classList.contains(this.hiddenClass);
  }

  initialize() {
    console.log("Hello World");
  }

  close(){
    this.isOpen = false;
    this.element.classList.add(this.hiddenClass)
  }

  open(){
    if(this.isOpen) return;
    this.isOpen = true;
    this.element.classList.remove(this.hiddenClass)
  }
}
