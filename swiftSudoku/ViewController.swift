//
//  ViewController.swift
//  数独辅助
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

/// 全屏宽度
let GYWWitdh = UIScreen.main.bounds.width

class ViewController: UIViewController {
    
    ///数组未从左到右从上到下排列
    
    var dataArray : Array<Array<Array<Int>>>! //数组的a[0]用来存储每一行的可填数，a[1]用来存储每一列的可填数，a[2]用来存储每一小宫格的可填数。有填没有则填0
    var InitialArray : Array<Array<Int>>! //初始的记录
    
    var NilArray : Array<Array<Int>>! //记录为空的位置
    //强行结束循环
    var EndWhile = false
    
    @IBOutlet weak var OpenBtn: UIButton!
    
    @IBOutlet weak var EndText: UILabel!
    var count_way : Int = 0
    //九个块从左到右从上到下
    var oneview : smallview!
    var tweview : smallview!
    var threeview : smallview!
    var fourview : smallview!
    var fiveview : smallview!
    var sixview : smallview!
    var sevenview : smallview!
    var eightview : smallview!
    var nineview : smallview!
    
    var viewArray : [smallview]!
    
    var ResultArray : [[[Int]]]! = [[[]]] as! [[[Int]]]
    //需要得到最少几个解
    var Result : Int = 10
    
    @IBOutlet weak var BackView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.upUi()
        
    }
    
    /// 绘制界面,添加9个小的九宫格
    func upUi() {
        self.BackView.frame = CGRect.init(x: 10, y: 50, width: GYWWitdh - 20, height: GYWWitdh - 20)
        let longCount = (GYWWitdh - 30)/3
        print(GYWWitdh,longCount)
        oneview = smallview.smallviewWihtXib()
        oneview.frame = CGRect.init(x: 0, y: 0, width: longCount, height: longCount)
        self.BackView.addSubview(oneview)
        
        tweview = smallview.smallviewWihtXib()
        tweview.frame = CGRect.init(x: (longCount + 5), y: 0, width: longCount, height: longCount)
        self.BackView.addSubview(tweview)

        threeview = smallview.smallviewWihtXib()
        threeview.frame = CGRect.init(x: 2 * (longCount + 5), y: 0, width: longCount, height: longCount)
        self.BackView.addSubview(threeview)
        
        fourview = smallview.smallviewWihtXib()
        fourview.frame = CGRect.init(x: 0, y: (longCount + 5), width: longCount, height: longCount)
        self.BackView.addSubview(fourview)
        
        fiveview = smallview.smallviewWihtXib()
        fiveview.frame = CGRect.init(x: (longCount + 5), y: (longCount + 5), width: longCount, height: longCount)
        self.BackView.addSubview(fiveview)
        
        sixview = smallview.smallviewWihtXib()
        sixview.frame = CGRect.init(x: 2 * (longCount + 5), y: (longCount + 5), width: longCount, height: longCount)
        self.BackView.addSubview(sixview)
        
        sevenview = smallview.smallviewWihtXib()
        sevenview.frame = CGRect.init(x: 0, y: 2 * (longCount + 5), width: longCount, height: longCount)
        self.BackView.addSubview(sevenview)
        
        eightview = smallview.smallviewWihtXib()
        eightview.frame = CGRect.init(x: (longCount + 5), y: 2 * (longCount + 5), width: longCount, height: longCount)
        self.BackView.addSubview(eightview)
        
        nineview = smallview.smallviewWihtXib()
        nineview.frame = CGRect.init(x: 2 * (longCount + 5), y: 2 * (longCount + 5), width: longCount, height: longCount)
        self.BackView.addSubview(nineview)
        
        self.viewArray = [oneview,tweview,threeview,fourview,fiveview,sixview,sevenview,eightview,nineview]
    }
    
    
    ///初始化数据,准备新一次运算
    func NewData() {
        //导入数据
        //先手写
        let tempArray = [0,0,0,0,0,0,0,0,0] //1是已经填数,0是没有
        let Hkarray = [tempArray,tempArray,tempArray,tempArray,tempArray,tempArray,tempArray,tempArray,tempArray]
        self.dataArray = [Hkarray,Hkarray,Hkarray]
        //初始化
        let NiltempArray = [-1,-1,-1,-1,-1,-1,-1,-1,-1] //待填为-1 ,初始未0-8
        self.InitialArray = [[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
        self.NilArray = [NiltempArray,NiltempArray,NiltempArray,NiltempArray,NiltempArray,NiltempArray,NiltempArray,NiltempArray,NiltempArray]
        self.count_way = 0
    }
    
    //从块排列到行排列 一个简单的函数也可以写成宏
    func DJK(Y: Int ,X : Int) -> Int {
        return 3 * Int(Y/3)+Int(X/3)
    }
    
    
    //解析数据并出结果
    func Feasiblesolution() {
        for i in 0...8 //行
        {
            for j in 0...8 //列
            {
                
                //从第一个位置起，获取a的3个数组的交集，也就是下一个可填的数
                if InitialArray[i][j] != -1 {//有值
                    //每行可填
                    dataArray[0][i][InitialArray[i][j]] = 1
                    //每列可填
                    dataArray[1][j][InitialArray[i][j]] = 1
                    //每快可填
                    dataArray[2][DJK(Y: i, X: j)][InitialArray[i][j]] = 1
                    //未空
                    NilArray[i][j] = 0
                }
            }
        }
        
        //从头开始计算
        solve(Y: 0, X: 0, ANilArray: self.NilArray, AdataArray: self.dataArray, AInitialArray: self.InitialArray);
        
    }
    
    ///以当前坐标的当前值为基准，寻找交集中得出一个可填数  有返回几,没有则倒退-1
    func getNext(Y : Int , X : Int , start : Int ,AdataArray :[[[Int]]]! ) -> Int {
        var TempdataArray : [[[Int]]]! = AdataArray
        if start >= 8 {//防止越级
            return -1
        }
        for i in start...8 {
            if TempdataArray[0][Y][i] == 0 && TempdataArray[1][X][i] == 0  && TempdataArray[2][DJK(Y: Y, X: X)][i] == 0  {
                return i
            }
        }
        return -1
    }
    
    //改写可填数数组的数据
    func changeRule( style : Int , X : Int , Y : Int, AInitialArray: [[Int]]!,AdataArray :[[[Int]]]!) -> [[[Int]]]!{
        var TempInitialArray : [[Int]]! = AInitialArray
        var TempdataArray : [[[Int]]]! = AdataArray
        
        TempdataArray[0][Y][TempInitialArray[Y][X]] = style
        TempdataArray[1][X][TempInitialArray[Y][X]] = style
        TempdataArray[2][DJK(Y: Y, X: X)][TempInitialArray[Y][X]] = style
        
        return TempdataArray
    }
    
    //处理数据
    func solve(Y : Int, X : Int , ANilArray : [[Int]]! ,AdataArray :[[[Int]]]!, AInitialArray: [[Int]]!) { //为 0-8
        
        //        print("循环一次开始为\(Y)行\(X)列")
        var x : Int = X //从0开始
        var y : Int = Y
        var TempNilArray : [[Int]]! = ANilArray
        var TempdataArray : [[[Int]]]! = AdataArray
        var TempInitialArray : [[Int]]! = AInitialArray
        
        if x == 9 { //超出一行
            y += 1
            x = 0
        }
        
        while  y < 9 &&  TempNilArray[y][x] == 0 {//下一个可以填入的位置
            x += 1
            if x == 9 {
                y += 1
                x = 0
            }
        }
        
        if y == 9 { //一个循环,有结果
            y = 0
            x += 1
            self.ResultArray.append(TempInitialArray)
            self.count_way += 1
            if count_way >= 10 {
                 self.EndText.text = "至少10个解"
            } else if count_way >= 1 {
               self.EndText.text = "得出\(Int(count_way))个解"
            }
            
            if self.count_way == 1  {
                self.ReturnResult(EndArray: TempInitialArray)
                self.OpenBtn.isUserInteractionEnabled = true
                self.OpenBtn.setTitle("开始计算", for: UIControlState.normal)
            }
            return
        }
        
        //第一次都是填入1从1开始
        while getNext(Y: y, X: x, start: TempInitialArray[y][x] + 1,AdataArray : TempdataArray) != -1  { //有可以写入的值
            
            TempInitialArray![y][x] = getNext(Y: y, X: x, start: TempInitialArray[y][x] + 1,AdataArray : TempdataArray)
            
            TempdataArray = changeRule(style: 1, X: x, Y: y, AInitialArray: TempInitialArray, AdataArray: TempdataArray)
            
            solve(Y: y, X: x + 1, ANilArray: TempNilArray, AdataArray: TempdataArray, AInitialArray: TempInitialArray)//开始循环  符合则继续填,不符合则做回退处理改值
            
            if self.EndWhile {
                print("强制退出")
                return
            }
            if self.count_way > Result  {
                print("得出一个解开始退出循环")
                return
            }
            //抹掉之前的选择将可选值回退
            TempdataArray = changeRule(style: 0, X: x, Y: y, AInitialArray: TempInitialArray, AdataArray: TempdataArray)
            
        }
        
    }
    
    //转换数据
    @IBAction func Click(_ sender: Any) {
       
        //清洗数据
        self.NewData()
        var tempArray = [] as! [[Int]]
        for view in self.viewArray {
            tempArray.append(view.loadviewData())
        }
        for i in 0...8 {
            for j in 0...8 {
                self.InitialArray[i][j] = tempArray[(3 * Int(i/3) + Int(j/3))][(j%3) + 3 * (i%3)]
            }
        }
        
//        if !self.CheckingData(RowArray: self.InitialArray, PieceArray: tempArray) {
//            print("有问题退出这次解析")
//            self.nilView(self.OpenBtn)
//            self.EndText.text = "数据有误请重新输入"
//           return
//        }
        print("开始解析")
        self.EndText.text = "计算中"

        self.OpenBtn.setTitle("解析中", for: UIControlState.normal)
        self.OpenBtn.isUserInteractionEnabled = false
        self.self.EndWhile = false
        
        ///开始计算
        self.Feasiblesolution()
        //打印结果
        for Result in ResultArray {
            print("得到的解为\(Result)")
        }
    }
    ///写入数据
    func ReturnResult(EndArray : [[Int]]! ){
        var tempArray = [] as! [[Int]]
        for _ in 0...8 {
            tempArray.append([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        }
        for i in 0...8 {
            for j in 0...8 {
                tempArray[i][j] = EndArray[(3 * Int(i/3) + Int(j/3))][((j%3) + 3 * (i%3))]
            }
        }
        for count in 0...8 {
            self.viewArray[count].DisplayResults(tempArray[count])
        }
    }
    ///清空
    @IBAction func nilView(_ sender: Any) {
        //清洗数据
        self.NewData()
        for count in 0...8 {
            self.viewArray[count].loadNil()
        }
        self.OpenBtn.isUserInteractionEnabled = true
        self.OpenBtn.setTitle("开始计算", for: UIControlState.normal)
        self.EndWhile = true
        self.EndText.text = "..."
    }
    
    /// 行,块 检查数据
    ///   - RowArray: 行数组
    ///   - PieceArray: 块数组
    func CheckingData(RowArray : [[Int]]!  ,PieceArray : [[Int]]! ) -> Bool {
     
        //将行改成列
        var tempArray = [] as! [[Int]]
        for _ in 0...8 {
            tempArray.append([-1,-1,-1,-1,-1,-1,-1,-1,-1])
        }
        for i in 0...8 {
            for j in 0...8 {
                tempArray[i][j] = RowArray[j][i]
            }
        }
        
        if arrayPD(array: RowArray) && arrayPD(array: PieceArray) && arrayPD(array: tempArray){
            //数据没有错误
            print("数据合格")
            return true
        }
        print("数据有问题")
        return false
    }
    
    func arrayPD(array : [[Int]]!) -> Bool {
        
        for i in 0...8 {
            let onearray = array[i].filter { a in a >= 0 } //去零数组
            if onearray != onearray.filterDuplicates({$0}) { //去重复数组 //数组不统一则重复
                return false
            }
            
        }
        
        return true
    }
}

extension Array {
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

