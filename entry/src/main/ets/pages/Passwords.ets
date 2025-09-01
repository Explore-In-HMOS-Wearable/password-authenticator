import PasswordList from '../view/PasswordList'

@Entry
@Component
struct Passwords {
  build() {
    Column() {
      PasswordList()
    }
  }
}