@CustomDialog
export struct CustomDialogDate {
  controller?: CustomDialogController;
  cancel: () => void = () => {
  }
  confirm: (time: Date) => void = () => {
  }
  timer: Date = new Date(new Date().setDate(new Date().getDate() + 1))
  @State selectTime: Date = this.timer

  build() {
    Column() {
      Text('请选择就诊时间')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .margin(10)
        .border({ width: { bottom: 1 } })
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ bottom: 5 })
        .borderColor('#999')

      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Button('确认选择', { type: ButtonType.Normal }).borderRadius(5).backgroundColor('#ff0839ec')
          .onClick(() => {
            this.confirm(this.selectTime)
          })
        Button('取消', { type: ButtonType.Normal }).borderRadius(5).backgroundColor('#ffee1111')
          .onClick(() => {
            this.controller?.close()
          })
      }.padding(10)

      DatePicker({
        start: this.timer
      }).onDateChange(value => {
        this.selectTime = value
      })
    }
  }
}

@CustomDialog
export struct CustomDialogCode {
  controller?: CustomDialogController;
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  code: string = ""

  build() {
    Column() {
      Text('请使用微信扫码支付')
        .fontSize(15)
        .fontWeight(FontWeight.Bold)
        .margin(10)
        .border({ width: { bottom: 1 } })
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ bottom: 5 })
        .borderColor('#999')
      QRCode(this.code).width(140).height(140)
      Text('X')
        .border({ width: 1 })
        .borderRadius('50%')
        .width(20)
        .height(20)
        .margin(20)
        .textAlign(TextAlign.Center)
        .onClick(()=>{
          this.confirm()
        })
    }
  }
}