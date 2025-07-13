import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    this.timeout = setTimeout(() => {
      this.closeAll()
    }, 4000)
  }

  close(event) {
    event.currentTarget.parentElement.remove()
  }

  closeAll() {
    this.messageTargets.forEach((el) => {
      el.remove()
    })
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
