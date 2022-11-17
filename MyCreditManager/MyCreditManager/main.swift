//
//  main.swift
//  MyCreditManager
//
//  Created by 홍승완 on 2022/11/16.
//

import Foundation


// 학생 class
class Students {
    var name: String
    var subjects: [String:String] = [:]
    init(name: String) {
        self.name = name
    }
}

// 학생 class 리스트
var studentList: [Students] = []
var quit : Bool = false

// MARK: - 학생 추가
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

// MARK: - 학생 삭제
func deleteStudent(){
    print("삭제할 학생의 이름을 입력해주세요")

    let input = readLine()!
    var check: Bool = false
    
    var idx = 0
    for student in studentList {
        if student.name == input {
            print("\(input) 학생을 삭제하였습니다.")
            studentList.remove(at: idx)
            check = true
        }
        idx+=1
    }
    
    if !check {
        print("\(input) 학생을 찾지 못했습니다.")
    }
    
}

// MARK: - 성적추가
func addSubject(){
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰길 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    let input = readLine()!
    
    let studentName: String
    let subject: String
    let subjectScore: String
    
    // 먼저 input으로 들어온 문자열을 공백을 기준으로 나누어서 name subject score로 저장함
    let splitInput = input.split(separator: " ")
    
    // 잘못입력하는 경우?
    // 1. 3가지가 아닌경우
    // 2. 학생이 이름이 없는경우
    
    // 공백기준 3가지 입력이 아닌경우
    if splitInput.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
        return
    } else {
        studentName = String(splitInput[0])
        subject = String(splitInput[1])
        subjectScore = String(splitInput[2])
    }
    
    // 학생이름 존재하는지 확인
    let hasStudent = studentList.contains { student -> Bool in
        if student.name == studentName {
            return true
        } else {
            return false
        }
    }
    
    // 학생이름 없으면 리턴
    if !hasStudent {
        print("\(studentName) 학생을 찾지 못했습니다.")
        return
    }
    
    // 성적이 잘못 입력되면 리턴
    let Scores = ["A+","A","B+","B","C+","C","D+","D","F"]
    let correctScore = Scores.contains(subjectScore)
    if !correctScore {
        print("성적 입력이 올바르지 않습니다.")
        return
    }
    
    
    
    for student in studentList {
        if student.name == studentName {
            student.subjects[subject] = subjectScore
            print("\(studentName) 학생의 \(subject) 과목이 \(subjectScore)로 추가(변경)되었습니다.")
            print(student.subjects)
            return
        }
    }

    
}


func startFunc(_ cases: String){
    
    switch cases{
    case "1" : // 학생 추가
        addStudent()
    case "2" : // 학생 삭제
        deleteStudent()
    case "3" : // 성적추가(변경)
        addSubject()
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



