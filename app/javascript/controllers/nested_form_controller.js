import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['add_object', 'template']

  connect() {
    console.log(this.templateTarget.innerHTML)
  }

  add_association(e) {
    e.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/'NEW_RECORD'/g, new Date().getTime().toString())
    this.add_objectTarget.insertAdjacentHTML('beforebegin', content)

    const event = new CustomEvent('nested-form:add_association', { bubbles: true })
    this.element.dispatchEvent(event)
  }

  remove_association(e) {
    e.preventDefault()
    const item = e.target.closest('.nested-fields')
    item.querySelector("input[name*='_destroy']").value = '1'
    item.style.display = 'none'

    const event = new CustomEvent('nested-form:remove_association', { bubbles: true })
    this.element.dispatchEvent(event)
  }
}
