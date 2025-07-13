import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "backdrop"]

  connect() {
    // Restaurer l'état de la sidebar depuis localStorage
    this.sidebarOpen = localStorage.getItem('sidebarOpen') === 'true'
    this.updateSidebarState()
  }

  toggle() {
    this.sidebarOpen = !this.sidebarOpen
    localStorage.setItem('sidebarOpen', this.sidebarOpen)
    this.updateSidebarState()
  }

  updateSidebarState() {
    if (this.sidebarOpen) {
      this.sidebarTarget.classList.remove('-translate-x-full')
      this.sidebarTarget.classList.add('translate-x-0')
      this.backdropTarget.classList.add('hidden')
    } else {
      this.sidebarTarget.classList.add('-translate-x-full')
      this.sidebarTarget.classList.remove('translate-x-0')
      this.backdropTarget.classList.remove('hidden')
    }
  }
}