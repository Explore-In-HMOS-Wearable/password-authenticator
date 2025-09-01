import Password from '../viewmodel/PasswordModel'
import { router } from '@kit.ArkUI'
import { PasswordManager } from '../viewmodel/PasswordManager'

@Component
export default struct PasswordStack {
  @State newApp: string = ''

  pushPassword() {
    if (this.newApp.trim() !== '') {
      const newPwd = new Password(this.newApp.trim())
      PasswordManager.instance().password.push(newPwd)
      this.newApp = ''
    }
  }

  popPassword() {
    if (PasswordManager.instance().password.length > 0) {
      PasswordManager.instance().password.pop()
    }
  }

  build() {
    Column() {
      TextInput({ placeholder: 'Enter account', text: this.newApp }).margin(15)
        .onChange((val: string) => this.newApp = val)
      Button('Add').margin({ bottom: 15 }).backgroundColor(Color.Red)
        .onClick(() => {
          this.pushPassword()
          router.back()
        }
        )
      Button('Remove').backgroundColor(Color.Red)
        .onClick(() => {
          this.popPassword()
          router.back()
        })
    }
    .padding(20)
  }
}
