@Component
export default struct RandomNumberComponent {
  @State randomValue: string = '000000';
  @State seconds: number = 0
  private intervalId: number | undefined = undefined;

  generateSixDigitNumber(): string {
    const randomNum = Math.floor(100000 + Math.random() * 900000);
    return randomNum.toString();
  }

  aboutToAppear() {
    this.randomValue = this.generateSixDigitNumber();
    this.intervalId = setInterval(() => {
      this.seconds += 1;

      if (this.seconds >= 30) {
        this.seconds = 0;
        this.randomValue = this.generateSixDigitNumber();
      }
    }, 1000);
  }

  aboutToDisappear() {
    if (this.intervalId !== undefined) {
      clearInterval(this.intervalId);
      this.intervalId = undefined;
    }
  }

  build() {
    Column() {
      Progress({ value: this.seconds, total: 30, type: ProgressType.Ring, }).width(40)
        .style({ enableScanEffect: true }).color(Color.Red)
      Text('Your 6-digit random number:')
        .fontSize(12)
        .margin({ bottom: 10, top: 10 })

      Text(this.randomValue)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Red)
        .margin({ bottom: 10 })

      Text('(It changes every 30 seconds)')
        .fontSize(10)
        .fontColor(Color.Grey)
    }.padding(20)
  }
}
