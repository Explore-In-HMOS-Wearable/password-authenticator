import Password from '../viewmodel/PasswordModel'
import { ArcList, ArcListItem, ArcListAttribute, router } from '@kit.ArkUI';
import RandomNumberComponent from '../view/SecureRandomMock'
import { PasswordManager } from '../viewmodel/PasswordManager';

@Component
export default struct PasswordList {
  private watchSize: string = '466px'
  private listSize: string = '420px'

  build() {
    Flex({ justifyContent: FlexAlign.Center }) {
      ArcList() {
        ForEach(PasswordManager.instance().password, (pwd: Password) => {
          ArcListItem() {
            Column() {
              Title({ title: pwd.account })
              RandomNumberComponent()
            }
          }
        }, (pwd: Password) => JSON.stringify(pwd))
      }.width(this.listSize)
    }.width(this.watchSize)
    .height(this.watchSize)
  }
}

@Component
struct Title {
  @Prop title: string;
  fontSize: number = 20;

  build() {
    Row() {
      Text(this.title)
        .onClick(() => {
          router.pushUrl({ url: 'pages/AddPassword' })
        })
        .fontSize(this.fontSize)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
        .margin({ top: 10 })
    }
  }
}
