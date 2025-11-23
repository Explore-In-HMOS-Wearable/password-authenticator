import PasswordList from '../view/PasswordList'

@Component
export struct Passwords {
  @Consume('pathStack') pathStack: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        PasswordList()
      }
    }
    .hideTitleBar(true)
    .hideBackButton(true)
  }
}