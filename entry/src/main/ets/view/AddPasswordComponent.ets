import Password from '../viewmodel/PasswordModel'
import { router } from '@kit.ArkUI'
import { PasswordManager } from '../viewmodel/PasswordManager'

@Component
export default struct PasswordStack {
  @State newApp: string = ''
  @Consume('pathStack') pathStack: NavPathStack;

  pushPassword() {
    if (this.newApp.trim() !== '') {
      const newPwd = new Password(this.newApp.trim())
      PasswordManager.instance().inputList.push(newPwd)
      this.newApp = ''
    }
  }

  popPassword() {
    if (PasswordManager.instance().inputList.length > 0) {
      PasswordManager.instance().inputList.pop()
    }
  }

  build() {
    Column() {
      TextInput({ placeholder: 'Enter account', text: this.newApp }).margin(15)
        .onChange((val: string) => this.newApp = val)
      Button('Add').margin({ bottom: 15 }).backgroundColor(Color.Red)
        .onClick(() => {
          this.pushPassword()
          this.pathStack.pop()

        }
        )
      Button('Remove').backgroundColor(Color.Red)
        .onClick(() => {
          this.popPassword()
          this.pathStack.pop()
        })
    }
    .padding(20)
  }
}
