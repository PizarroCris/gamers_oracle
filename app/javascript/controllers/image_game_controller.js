import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "fileNameDisplay"]

  connect() {
    this.fileInputTarget.addEventListener('change', this.updateFileName.bind(this));
  }

  updateFileName() {
    const fileName = this.fileInputTarget.files[0] ? this.fileInputTarget.files[0].name : 'Nenhum arquivo selecionado';
    this.fileNameDisplayTarget.textContent = fileName;
  }
}
