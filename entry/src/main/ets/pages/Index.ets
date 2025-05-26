import home from './home'
import { router } from '@kit.ArkUI'
import orders from './orders'
import my from './my'

interface params {
  index: number
}

@Entry
@Component
struct Index {
  TabsController: TabsController = new TabsController()
  @State changeFlag: boolean = true

  onPageShow(): void {
    if (router.getParams()) {
      let index = (router.getParams() as params).index
      this.TabsController.changeIndex(index)
    }
    this.changeFlag = true
  }

  onPageHide(): void {
    this.changeFlag = false
  }

  build() {
    Tabs({ index: 2, barPosition: BarPosition.End, controller: this.TabsController }) {
      TabContent() {
        home()
      }.tabBar(
        '首页'
      )

      TabContent() {
        orders({ changeFlag: this.changeFlag }).height('100%')
      }.tabBar(
        '订单'
      )

      TabContent() {
        my().height('100%')
      }.tabBar(
        '我的'
      )
    }
  }
}