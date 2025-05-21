import schedule from '../component/schedule'
import { getCompanion, return_companion_type } from '../api/api'
import { CustomDialogDate } from '../component/dialog'

interface obj_list {
  hospital_name: string,
  time: string
  companion_name: string
  receiveAddress: string
  tel: string,
}

interface form_list_type {
  hospital_name: string,
  starttime: number | undefined
  companion_name: string
  receiveAddress: string
  tel: string
  demand: string
  hospital_id: number | undefined
  companion_id: number | undefined
  time: string
}


@Entry
@Component
struct CreateOrder {
  @State orderData: return_companion_type | undefined = undefined
  list: obj_list = {
    hospital_name: "就诊医院",
    time: "就诊时间",
    companion_name: "陪诊师",
    receiveAddress: "接送地址",
    tel: "联系电话",
  }
  @State text_dialog_type: string = 'hospital_name'
  @State rangeList: Array<Array<string | number>> = []
  @State form_list: form_list_type = {
    hospital_name: "请选择医院",
    hospital_id: undefined,
    starttime: undefined,
    time: "请选择就诊时间",
    companion_name: "请选择陪诊师",
    companion_id: undefined,
    receiveAddress: "请填写就诊人地址",
    tel: "请填写您的联系方式",
    demand: "请简单描述你要就诊的科室"
  }
  TextDialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: () => {
      },
      confirm: (data: Array<string | number>) => {
        this.textConfirmData(data)
      },
      type_title: this.text_dialog_type,
      rangeList: this.rangeList,
    }),
    offset: { dx: 0, dy: 200 }
  })
  DateDialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogDate({
      cancel: () => {
      },
      confirm: (time: Date) => {
        this.dateConfirmData(time)
      },
    }),
    offset: { dx: 0, dy: 200 }
  })

  textConfirmData(data: Array<string | number>) {
    if (this.text_dialog_type === 'hospital_name') {
      this.form_list.hospital_name = data[0] as string
      this.form_list.hospital_id = data[1] as number
    } else {
      this.form_list.companion_name = data[0] as string
      this.form_list.companion_id = data[1] as number
    }

    this.TextDialogController?.close()
  }

  formaDate(time: Date) {
    const year = time.getFullYear().toString()
    const month = (time.getMonth() + 1).toString().padStart(2, '0')
    const date = time.getDate().toString()
    return `${year}-${month}-${date}`
  }

  dateConfirmData(time: Date) {
    this.form_list.time = this.formaDate(time)
    this.form_list.starttime = time.getTime()
    this.DateDialogController?.close()
  }

  openDialog(name: string) {
    if (name === 'hospital_name') {
      this.text_dialog_type = name
      this.rangeList = this.orderData?.hospitals.map(item => {
        return [item.name, item.id]
      }) || []
      this.TextDialogController?.open()
    } else if (name === 'companion_name') {
      this.text_dialog_type = name
      this.rangeList = this.orderData?.companion.map(item => {
        return [item.name, item.id]
      }) || []
      this.TextDialogController?.open()
    } else if (name === 'time') {
      this.DateDialogController?.open()
    }

  }

  onPageShow(): void {
    getCompanion().then(res => {
      this.orderData = res
    })
  }

  build() {
    Column() {
      schedule({ typeIndex: 1 })

      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Row() {
          Image(this.orderData?.service.serviceImg)
            .width(25).margin({ right: 5 })
          Text(this.orderData?.service.serviceName).fontSize(13)
        }

        Text('服务内容').fontSize(13).fontColor('#969799')
      }.backgroundColor(Color.White).margin(5).padding(15)

      ForEach(Object.keys(this.list), (item: string) => {
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text(Reflect.get(this.list, item) as string).fontSize(13)
          if (item === 'receiveAddress' || item === 'tel') {
            TextInput({ text: Reflect.get(this.form_list, item) })
              .backgroundColor(Color.White)
              .fontSize(13)
              .fontColor('#969799')
              .width('60%')
              .textAlign(TextAlign.End)
              .padding(0)
              .borderRadius(0)
              .onChange(value => {
                Reflect.set(this.form_list, item, value)
              })
          } else {
            Text(Reflect.get(this.form_list, item) as string + ' >').fontSize(13).fontColor('#969799')
              .onClick(() => {
                this.openDialog(item)
              })
          }
        }.backgroundColor(Color.White).padding(15)
        .border({
          width: { bottom: 1 },
          color: '#f0f0f0'
        })
        .margin({ left: 5, right: 5 })
      })
      Text('服务需求')
        .margin(5)
        .fontSize(15)
        .fontColor('#969799')

      TextArea({ text: this.form_list.demand })
        .borderRadius(0)
        .backgroundColor(Color.White)
        .margin(5)
        .padding(15)
        .fontColor('#969799')
        .fontSize(13)
        .height(100)
        .onChange(value => {
          Reflect.set(this.form_list, "demand", value)
          // console.log("+++form", JSON.stringify(this.form_list))
        })

      Button('提交订单', { type: ButtonType.Normal })
        .borderRadius(5)
        .width('100%')
        .margin({ top: 10 })
        .onClick(() => {

        })

    }.backgroundColor('#f0f0f0')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@CustomDialog
struct CustomDialogExample {
  controller?: CustomDialogController;
  cancel: () => void = () => {
  }
  confirm: (data: Array<string | number>) => void = () => {
  }
  type_title: string = 'hospital_name'
  select: number = 0
  rangeList: Array<Array<string | number>> = []
  rang: string[] = []
  @State selectData: Array<string | number> = []

  getTitle() {
    return this.type_title === 'hospital_name' ? '请选择医院' : '请选择陪诊师'
  }

  aboutToAppear(): void {
    this.rang = this.rangeList.map(item => {
      return item[0] as string
    })
    this.selectData = this.rangeList[this.select]
  }

  build() {
    Column() {
      Text(this.getTitle())
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
            this.confirm(this.selectData)
          })
        Button('取消', { type: ButtonType.Normal }).borderRadius(5).backgroundColor('#ffee1111')
          .onClick(() => {
            this.controller?.close()
          })
      }.padding(10)

      TextPicker({ range: this.rang, selected: this.select })
        .canLoop(this.rang.length > 3 ? true : false)
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectData = this.rangeList[index as number]
        })
        .width('60%')
      if (this.rang.length === 0) {
        Text('暂无数据').fontSize(20).margin(50)
      }
    }
  }
}