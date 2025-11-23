import AddPasswordComponent from '../view/AddPasswordComponent'

@Component
export struct AddPassword {
  @Consume('pathStack') pathStack: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        AddPasswordComponent()
      }
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}
