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