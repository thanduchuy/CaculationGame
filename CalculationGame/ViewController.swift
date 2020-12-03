//
//  ViewController.swift
//  CalculationGame
//
//  Created by Huy Than Duc on 30/11/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionViewCaculation: UICollectionView!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var numberQuestion: UILabel!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var resetNumber: UIImageView!
    @IBOutlet weak var sentResult: UIButton!
    @IBOutlet weak var constrainTopView: NSLayoutConstraint!
    var keyboards : [ButtonCalculation] = [
        ButtonCalculation(value: "1",image: "1"),
        ButtonCalculation(value: "2",image: "2"),
        ButtonCalculation(value: "3",image: "3"),
        ButtonCalculation(value: "4",image: "4"),
        ButtonCalculation(value: "5",image: "5"),
        ButtonCalculation(value: "6",image: "6"),
        ButtonCalculation(value: "7",image: "7"),
        ButtonCalculation(value: "8",image: "8"),
        ButtonCalculation(value: "9",image: "9"),
        ButtonCalculation(value: "*",image: "cancel"),
        ButtonCalculation(value: "+",image: "plus"),
        ButtonCalculation(value: "-",image: "minus"),
        ButtonCalculation(value: "/",image: "division")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        configCaculatorCollection()
        styleAnswerView()
        resetNumber.layer.cornerRadius = resetNumber.frame.height/2
        sentResult.layer.cornerRadius = sentResult.frame.height/2
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        resetNumber.isUserInteractionEnabled = true
        resetNumber.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped() {
        answerTextView.text = ""
        loadAnswer()
    }
    func loadAnswer() {
        let number =  Int.random(in: 10..<100)
        numberQuestion.text = "\(number)"
        answerTextView.text = ""
        keyboards = [
            ButtonCalculation(value: "1",image: "1"),
            ButtonCalculation(value: "2",image: "2"),
            ButtonCalculation(value: "3",image: "3"),
            ButtonCalculation(value: "4",image: "4"),
            ButtonCalculation(value: "5",image: "5"),
            ButtonCalculation(value: "6",image: "6"),
            ButtonCalculation(value: "7",image: "7"),
            ButtonCalculation(value: "8",image: "8"),
            ButtonCalculation(value: "9",image: "9"),
            ButtonCalculation(value: "*",image: "cancel"),
            ButtonCalculation(value: "+",image: "plus"),
            ButtonCalculation(value: "-",image: "minus"),
            ButtonCalculation(value: "/",image: "division")
        ].shuffled()
        collectionViewCaculation.reloadData()
    }
    func styleAnswerView() {
        loadAnswer()
        questionView.layer.cornerRadius = questionView.bounds.height / 2
        answerTextView.isEditable = false
        answerTextView.layer.cornerRadius = answerTextView.bounds.height/2
        answerTextView.textContainerInset =
            UIEdgeInsets(top: 30,left: 10, bottom: 10, right: 45);
    }
    func configCaculatorCollection() {
        keyboards.shuffle()
        collectionViewCaculation.delegate = self
        collectionViewCaculation.dataSource = self
        collectionViewCaculation.isUserInteractionEnabled = true
        collectionViewCaculation.register(KeyBoardCell.self, forCellWithReuseIdentifier: "KeyBoardCell")
        collectionViewCaculation.collectionViewLayout.invalidateLayout()

    }
    func checkOperator(text: String) -> Bool {
        return text == "+" || text == "-" || text == "*" || text == "/"
    }
    @IBAction func onClickSentResult(_ sender: Any) {
        if var s = answerTextView.text {
            s = s.filter({ (char) -> Bool in
                char != " "
            })
            let expn = NSExpression(format:s)
            let result =  expn.expressionValue(with: nil, context: nil) ?? 0
            let textShow = "\(result)" == numberQuestion.text ? "Chúc mừng bạn đã chiến thắng":"Chia buồn kết quả đã sai"
            let alert = UIAlertController(title: "Kết quả", message: textShow, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(action:UIAlertAction!) in
                self.loadAnswer()
            }))
            self.present(alert, animated: true)
        }
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orientation = UIApplication.shared.statusBarOrientation
                if(orientation == .landscapeLeft || orientation == .landscapeRight)
                {
                    heightCollection.constant = 260
                    if keyboards.count < 5 {
                        constrainTopView.constant = 20
                    } else {
                        constrainTopView.constant = 0
                    }
                    return CGSize(width: (collectionViewCaculation.bounds.width/6) - 10, height:80)
                }
                else{
                    heightCollection.constant = 350
                    return CGSize(width: (collectionViewCaculation.bounds.width/4) - 10, height:80)
                }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyboards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewCaculation.dequeueReusableCell(withReuseIdentifier: "KeyBoardCell", for: indexPath) as! KeyBoardCell
        let item = keyboards[indexPath.row]
        cell.styleKeyBoard(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = keyboards[indexPath.row]
        collectionViewCaculation.reloadData()
        if checkOperator(text: String(answerTextView.text.suffix(1))) &&
            checkOperator(text: item.value)
            {
            let alert = UIAlertController(title: "Không thể chọn thế đc", message: "Bạn không được chọn hai dấu liên tiếp", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            keyboards.remove(at: indexPath.row)
            answerTextView.text = "\(answerTextView.text ?? "") \(item.value)"
        }
    }
}
