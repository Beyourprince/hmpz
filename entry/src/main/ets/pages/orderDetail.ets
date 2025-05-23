import { router } from '@kit.ArkUI'
import { getDetail, return_detail_type } from '../api/api'
import schedule from '../component/schedule'

interface params {
  oid: string
}

@Entry
@Component
struct OrderDetail {
  @State order_data: return_detail_type | undefined = undefined
  appointment_from: Record<string, string> = {
    "service_name": "预约服务",
    "hospital_name": "就诊医院",
    "starttime": "期望就诊时间",
    "client.name": "就诊人",
    "client.mobile": "就诊人电话",
    "receiveAddress": "接送地址",
    "demand": "其他需求",
  }
  order_from: Record<string, string> = {
    "client.mobile": "联系电话",
    "order_start_time": "下单时间",
    "price": "应付金额",
    "out_trade_no": "订单编号",
    "other": "联系客服",
  }

  onPageShow(): void {
    let oid = ""
    if ((router.getParams() as params).oid) {
      oid = (router.getParams() as params).oid
    }
    getDetail({ oid }).then(res => {
      this.order_data = res
    })
  }

  getTypeIndex() {
    let str = this.order_data?.trade_state || '已取消'
    let typeArr: Record<string, number> = {
      "待支付": 1,
      "待服务": 2,
      "已完成": 3,
      "已取消": 4
    }
    return typeArr[str]
  }

  formaDate(seconds: number) {
    let time = new Date(seconds)
    const year = time.getFullYear().toString()
    const month = (time.getMonth() + 1).toString().padStart(2, '0')
    const date = time.getDate().toString()
    return `${year}-${month}-${date}`
  }

  getValue(str: string): string {
    let strArr = str.split('.')
    if (str === 'other') {
      return '疑问或投诉>'
    }
    if (str === 'order_start_time') {
      return this.formaDate(Reflect.get(this.order_data as return_detail_type, str))
    }
    if (strArr.length > 1) {
      let result: object | string = this.order_data as return_detail_type
      for (const element of strArr) {
        result = Reflect.get(result as object, element)
      }
      return result as string
    }
    return Reflect.get(this.order_data as return_detail_type, str)
  }

  build() {
    Scroll() {
      Column() {
        Text('订单详情')
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontSize(15)
          .lineHeight(20)
          .backgroundColor(Color.White)
          .padding(5)
        schedule({
          typeIndex: this.getTypeIndex()
        })
        Column() {
          Text('预约信息')
            .fontWeight(FontWeight.Bold)
            .border({ width: { left: 3 } })
            .borderColor(Color.Red)
            .padding(3)
            .fontSize(13)
          if (this.order_data) {
            ForEach(Object.keys(this.appointment_from), (item: string, index) => {
              Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                Text(this.appointment_from[item]).fontSize(13)
                Text(this.getValue(item)).fontColor('#999').fontSize(13)
              }.padding(10)
              .border({ width: { top: index === 0 ? 0 : 1 } }).borderColor('#ffebedf0')
            })
          }
        }.alignItems(HorizontalAlign.Start)
        .backgroundColor(Color.White).padding(10)

        Column() {
          Text('订单信息')
            .fontWeight(FontWeight.Bold)
            .border({ width: { left: 3 } })
            .borderColor(Color.Red)
            .padding(3)
            .fontSize(13)
          if (this.order_data) {
            ForEach(Object.keys(this.order_from), (item: string, index) => {
              Flex({ justifyContent: FlexAlign.SpaceBetween }) {
                Text(this.order_from[item]).fontSize(13)
                Text(this.getValue(item)).fontColor('#999').fontSize(13)
              }.padding(10)
              .border({ width: { top: index === 0 ? 0 : 1 } }).borderColor('#ffebedf0')
            })
          }
        }.alignItems(HorizontalAlign.Start)
        .backgroundColor(Color.White).padding(10)

      }.backgroundColor('#f0f0f0').height('100%')
    }
  }
}