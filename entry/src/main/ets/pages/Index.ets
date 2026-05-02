import { PromptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { vibrator } from '@kit.SensorServiceKit';
import { AddPassword } from './AddPassword';
import { Passwords } from './Passwords';

@Entry
@Component
struct Index {
  private uiContext: UIContext = this.getUIContext()
  private promptAction: PromptAction = this.uiContext.getPromptAction()
  @State email: string = '';
  @State input: string = ''
  private correctEmail: string = '';
  private correctInput: string = '';
  @Provide('pathStack') pathStack: NavPathStack = new NavPathStack()

  private triggerVibration(isSuccess: boolean) {
    try {
      vibrator.startVibration({
        type: 'preset',
        effectId: isSuccess ? 'haptic.success' : 'haptic.fail',
        count: 1
      }, {
        usage: 'notification'
      });
    } catch (error) {
      let err = error as BusinessError;
      console.error(`Vibration error: ${err.code} ${err.message}`);
    }
  }

  @Builder
  PageMap(name: string) {
    if (name === 'AddPassword') {
      AddPassword()
    } else if (name === 'Passwords') {
      Passwords()
    }
  }

  build() {
    Navigation(this.pathStack) {
      Stack() {
        Column({ space: 6 }) {
          Text('LOGIN')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.text_color'))
            .margin({ bottom: 4 })

          TextInput({ placeholder: 'E-mail' })
            .width('100%')
            .height(30)
            .fontSize(10)
            .placeholderFont({ size: 10 })
            .fontColor($r('app.color.text_color'))
            .backgroundColor($r('app.color.input_bg'))
            .borderRadius(4)
            .onChange((val) => this.email = val)

          TextInput({ placeholder: 'Password' })
            .width('100%')
            .height(30)
            .fontSize(10)
            .placeholderFont({ size: 10 })
            .fontColor($r('app.color.text_color'))
            .backgroundColor($r('app.color.input_bg'))
            .borderRadius(4)
            .type(InputType.Password)
            .onChange((val) => this.input = val)

          Text('Forgot?')
            .fontSize(8)
            .fontColor($r('app.color.brand_secondary'))
            .alignSelf(ItemAlign.End)

          Button('GO')
            .width('100%')
            .height(28)
            .fontSize(10)
            .borderRadius(4)
            .backgroundColor($r('app.color.brand_primary'))
            .fontColor($r('app.color.text_color'))
            .onClick(() => {
              this.checkCredentials(this.email === this.correctEmail && this.input === this.correctInput)
            })
        }
        .width('60%')
        .padding(12)
        .backgroundColor($r('app.color.start_window_background'))
        .borderRadius(8)
        .border({ width: 1, color: '#333333' })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#121212')
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .navDestination(this.PageMap)
  }

  checkCredentials(isValid: boolean) {
    this.triggerVibration(isValid);

    if (isValid) {
      this.promptAction.showToast({ message: 'Success', duration: 1500 });
      this.pathStack.pushPathByName('Passwords', null)
    } else {
      this.promptAction.showToast({ message: 'Failed', duration: 1500 });
    }
  }
}