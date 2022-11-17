//
//  main.swift
//  MyCreditManager
//
//  Created by 홍승완 on 2022/11/16.
//

import Foundation

class Students {
    var name: String
    var subjects: [String:String] = [:]
    init(name: String) {
        self.name = name
    }
}


var studentList: [Students] = []
var quit : Bool = false

func addStudent(){
    print("추가할 학생의 이름을 입력해주세요")

    let input = readLine()!
    var check: Bool = false
    
    // 잘못된 입력 들어오면 처리
    // 잘못된 입력케이스 -> "" 아무런 입력이 없는경우
    if input == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요")
        return
    }
    
    // 입력 잘못되면 return
    studentList.map { student in
        if student.name == input {
            print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            check = true
        }
    }

    if check {
        print("---------------------")
        print("현재 studentList 는")
        print("---------------------")
        studentList.map { student in
            print(student.name)
        }
        print("---------------------")
        return
    }
    
    // 입력 올바르면 list에 추가
    studentList.append(Students(name: input))
    print("\(input) 학생을 추가했습니다.")
}

func startFunc(_ cases: String){
    
    switch cases{
    case "1" : // 학생 추가
        addStudent()
    case "2" : // 학생 삭제
        print("2")
    case "3" : // 성적추가(변경)
        print("3")
    case "4" : // 성적삭제
        print("4")
    case "5" : // 평점보기
        print("5 asdasd")
    case "X" : // 종료
        print("X")
        quit = true
    default:
        print("절대 없음")
    }
}



while(true){
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5:평점보기, X: 종료")
    let inputs = readLine()!
    
    // 숫자일때 X일때 나눠서처리
    var isTrue = false
    
    ["1","2","3","4","5","X"].map {
        if inputs == String($0) {
            isTrue = true
            // case에 맞는 함수 실행
            startFunc(inputs)
        }
    }
    
    if !isTrue {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    if quit {
        print("종료합니다")
        break
    }
}



