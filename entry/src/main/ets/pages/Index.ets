import { router, PromptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct Index {
  private uiContext: UIContext = this.getUIContext()
  private promptAction: PromptAction = this.uiContext.getPromptAction()
  @State email: string = '';
  @State password: string = ''
  private correctEmail: string = '';
  private correctPassword: string = '';

  build() {
    Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceEvenly }) {

      Text('WELCOME')
        .width('35%')
        .textAlign(TextAlign.Start)
        .fontWeight(FontWeight.Bolder)

      TextInput({ placeholder: 'E-mail' })
        .width('80%')
        .margin(10)
        .type(InputType.Email)
        .onChange((email) => {
          this.email = email
          console.info(this.email + 'Enter key type')
        })

      TextInput({ placeholder: 'Password' })
        .width('80%')
        .onChange((password) => {
          this.password = password
          console.info(this.password + 'Enter key type')
        })
        .type(InputType.Password)
      Text('FORGOT PASSWORD?')
        .margin(10)
        .fontWeight(FontWeight.Bold)
        .decoration({
          type: TextDecorationType.Underline,
          color: Color.Black
        })
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('LOG IN')
          .textAlign(TextAlign.Start)
          .fontStyle(FontStyle.Normal)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .height(50)
      .backgroundColor(Color.Black)
      .onClick(() => {
        try {
          this.checkCredentials(this.email === this.correctEmail && this.password === this.correctPassword)

        } catch (error) {
          let message = (error as BusinessError).message
          let code = (error as BusinessError).code
        }
        ;
      })
    }.margin({ top: 20 })
  }

  checkCredentials(isValid: boolean) {
    if (isValid) {
      this.promptAction.showToast({
        message: 'WELCOME',
        duration: 2000
      });
      router.pushUrl({
        url: 'pages/Passwords'
      })

    } else {
      this.promptAction.showToast({
        message: 'Invalid E-mail or Password',
        duration: 2000
      });
    }
  }
}