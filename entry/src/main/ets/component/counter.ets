@Component
struct counter {
  @Prop allSeconds: number
  @State text: string = ''

  updateText(str: string) {
    this.text = str
  }

  startCountDown(allSeconds: number) {
    let totalSecond = Math.floor(allSeconds / 1000)
    const fn = () => {
      const hour = Math.floor(totalSecond / 3600)
      const min = Math.floor((totalSecond % 3600) / 60)
      const second = Math.floor(totalSecond % 60)
      const str =
        `${hour.toString().padStart(2, '0')}:${min.toString().padStart(2, '0')}:${second.toString().padStart(2, '0')}`
      this.updateText(str)
      if (totalSecond <= 0) {
        clearInterval(id)
      }
      totalSecond--
    }
    let id = setInterval(fn, 1000)
    fn()
  }

  aboutToAppear(): void {
    this.startCountDown(this.allSeconds)
  }

  build() {
    Column() {
      Text(this.text).fontSize(13).fontColor('#ffffa200')
    }
  }
}

export default counter