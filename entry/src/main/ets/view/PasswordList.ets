import Input from '../viewmodel/PasswordModel'
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
        ForEach(PasswordManager.instance().inputList, (inp: Input) => {
          ArcListItem() {
            Column() {
              Title({ title: inp.account })

              RandomNumberComponent()
            }
          }
        }, (inp: Input) => JSON.stringify(inp))
      }.width(this.listSize)
    }.width(this.watchSize)
    .height(this.watchSize)
  }
}

@Component
struct Title {
  @Prop title: string;
  fontSize: number = 20;
  @Consume('pathStack') pathStack: NavPathStack;

  build() {
      Text(this.title)
        .onClick(() => {
          this.pathStack.pushPathByName('AddPassword', null)
        })
        .fontSize(this.fontSize)
        .fontWeight(FontWeight.Bold)
        .fontStyle(FontStyle.Italic)
        .margin({ top: 10 })
  }
}
