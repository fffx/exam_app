import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.testId = this.element.dataset.id
    this.token = document.querySelector(
      'meta[name="csrf-token"]'
    ).content;
  }

  deleteQuestion(event) {
    this.delete(event)
  }

  deleteOption(event) {
    this.delete(event)
  }

  delete(event){
    var result = confirm("Are you sure?");
    if(!result) return

    var params = event.params
    console.log(params)
    if(params.questionId || params.optionId) {
      var url = ""
      if(params.optionId) {
        url = `/admin/tests/${this.testId}/options/${params.optionId}`
      } else {
        url = `/admin/tests/${this.testId}/questions/${params.questionId}`
      }
      fetch(url, {
          method: 'DELETE',
          headers: {
            'X-CSRF-Token': this.token,
            'Accept': "text/vnd.turbo-stream.html, text/html",
          }
        }
      ).then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html))
    } else {
      event.target.closest("fieldset").remove()
    }
  }
}
