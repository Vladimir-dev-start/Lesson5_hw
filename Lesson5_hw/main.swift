//
//  main.swift
//  Lesson5_hw
//
//  Created by Владимир on 19.04.2021.
//

import Foundation

enum EngineActivityStatus: String {
    case running = "Двигатель запущен"
    case notRunning = "Двигатель не запущен"
}

enum WindowPosition: String {
    case opened = "Окна открыты"
    case closed = "Окна закрыты"
}

enum HoodPosition: String {
    case opened = "Капот открыт"
    case closed = "Капот закрыт"
}

enum OpenHoodIndicator: String {
    case active = "Индикатор включен"
    case disactive = "Индикатор выключен"
}

enum TurboModeStatus: String {
    case active = "Турбо режим включен"
    case disactive = "Турбо режим выключен"
}

enum RetractableRearWing: String {
    case advanced = "Спойлер выдвинут"
    case closed = "Спойлер спрятан"
}

enum NitrousOxideLevel: String {
    case fullBallon = "Полный баллон закиси азота"
    case emptyBalloon = "Пустой баллон закиси азота"
}

enum PositionTrailer: String {
    case connected = "Прицеп соединен"
    case disconnected = "Прицеп разъединен"
}

enum FullnessOfTheCargoCompartment: String {
    case emptyCargoCompartment = "Грузовой отсек пуст"
    case filledInAt25Per = "Заполнен на 25%"
    case filledInAt50Per = "Заполнен на 50%"
    case filledInAt75Per = "Заполнен на 75%"
    case filledInAt100Per = "Заполнен полностью"
}

protocol CarProtocol: class {
    
    var carBrand: String { get }
    var yearOfRelease: String { get }
    var upperHatch: Bool { get }
    var engineActivityStatus: EngineActivityStatus { get set }
    var windowPosition: WindowPosition { get set }
    var hoodPosition: HoodPosition { get set }
    var openHoodIndicator: OpenHoodIndicator { get }
    
    func changeHoodPosition(_ action: HoodPosition)
    func changeEngineActivityStatus(_ action: EngineActivityStatus)
    func changeWindowPosition(_ action: WindowPosition)
}

extension CarProtocol {
    
    func changeHoodPosition(_ action: HoodPosition) {
        hoodPosition = action
    }
}

extension CarProtocol {
    
    func changeEngineActivityStatus(_ action: EngineActivityStatus) {
        engineActivityStatus = action
    }
}

extension CarProtocol {
    
    func changeWindowPosition(_ action: WindowPosition) {
        windowPosition = action
    }
}

class SportCar: CarProtocol {
    
    let carBrand: String
    let yearOfRelease: String
    let upperHatch: Bool
    var engineActivityStatus: EngineActivityStatus {
        willSet {
            if newValue == .notRunning {
                turboModeStatus = .disactive
            }
        }
    }
    var windowPosition: WindowPosition
    var hoodPosition: HoodPosition
    var openHoodIndicator: OpenHoodIndicator
    {
        switch self.hoodPosition {
        case .opened:
            return .active
        case .closed:
            return .disactive
        }
        
    }
    
    var retractableRearWing: RetractableRearWing
    
    private var turboModeStatus: TurboModeStatus = .disactive
    var nitrousOxideLevel: NitrousOxideLevel{
        
        willSet {
            if newValue == .emptyBalloon {
                turboModeStatus = .disactive
            }
        }
    }
    
    init(carBrand: String, yearOfRelease: String, upperHatch: Bool, engineActivityStatus: EngineActivityStatus, windowPosition: WindowPosition, hoodPosition: HoodPosition, retractableRearWing: RetractableRearWing, nitrousOxideLevel: NitrousOxideLevel) {
        
        self.carBrand = carBrand
        self.yearOfRelease = yearOfRelease
        self.upperHatch = upperHatch
        self.engineActivityStatus = engineActivityStatus
        self.windowPosition = windowPosition
        self.hoodPosition = hoodPosition
        self.retractableRearWing = retractableRearWing
        self.nitrousOxideLevel = nitrousOxideLevel
    }
    
    func changeTurboModeStatus(_ action: TurboModeStatus) {
        
        guard engineActivityStatus == .running && nitrousOxideLevel == .fullBallon else {
            return
        }
        turboModeStatus = action
        
    }
    
    func changeRetractableRearWing(_ action: RetractableRearWing) {
        retractableRearWing = action
    }
    
    func changeEngineActivityStatus(_ action: EngineActivityStatus) {
        
        engineActivityStatus = action
        
        switch action {
        case .running:
            print("Подача сигнала ремня безопасности")
        case .notRunning:
            print("Разблокировка дверей")
        }
    }
}

extension SportCar: CustomStringConvertible {
    
    var description: String {
        
        return
"""
 Марка машины - \(carBrand)\n Год выпуска - \(yearOfRelease)\n Наличие люка - \(upperHatch ? "есть" : "нет")\n Состояния двигателя - \(engineActivityStatus.rawValue)\n Состояние окон - \(windowPosition.rawValue)\n Положение капота - \(hoodPosition.rawValue)\n Состояние индикатора положения капота - \(openHoodIndicator.rawValue)\n Состояние спойлера - \(retractableRearWing.rawValue)\n Уровень закиси азота - \(nitrousOxideLevel.rawValue)\n Статус Турбо-режима - \(turboModeStatus.rawValue)
"""
    }
}

var mySportCarOne = SportCar(carBrand: "Ferrari", yearOfRelease: "2010", upperHatch: true, engineActivityStatus: .notRunning, windowPosition: .closed, hoodPosition: .closed, retractableRearWing: .closed, nitrousOxideLevel: .fullBallon)

//--- запуск двигателя
mySportCarOne.changeEngineActivityStatus(.running)

//--- включение Турбо-режима
mySportCarOne.changeTurboModeStatus(.active)

//--- завершение работы двигателя
mySportCarOne.changeEngineActivityStatus(.notRunning)
//--- Турбо-режим отключился автоматически

print(mySportCarOne)

var mySportCarTwo = SportCar(carBrand: "Aston Martin", yearOfRelease: "2015", upperHatch: true, engineActivityStatus: .running, windowPosition: .opened, hoodPosition: .closed, retractableRearWing: .closed, nitrousOxideLevel: .fullBallon)

//--- выдвигаем спойлер
mySportCarTwo.changeRetractableRearWing(.advanced)

print(mySportCarTwo)

class TrunkCar: CarProtocol {
    
    let carBrand: String
    let yearOfRelease: String
    let upperHatch: Bool
    var engineActivityStatus: EngineActivityStatus
    var windowPosition: WindowPosition
    var hoodPosition: HoodPosition
    var openHoodIndicator: OpenHoodIndicator{
        
        switch self.hoodPosition {
        case .opened:
            return .active
        case .closed:
            return .disactive
        }
    }
    
    let cargoCompartmentVolume: Double
    var fullnessOfTheCargoCompartment: FullnessOfTheCargoCompartment
    var positionTrailer: PositionTrailer
    
    //--- под каждый груз своя максимальная скорость
    
    private var maxSpeed: Int {
        switch fullnessOfTheCargoCompartment {
        case .emptyCargoCompartment:
            return 140
        case .filledInAt25Per:
            return 130
        case .filledInAt50Per:
            return 100
        case .filledInAt75Per:
            return 80
        case .filledInAt100Per:
            return 60
            
        }
    }
    
    init(carBrand: String, yearOfRelease: String, upperHatch: Bool, engineActivityStatus: EngineActivityStatus, windowPosition: WindowPosition, hoodPosition: HoodPosition, cargoCompartmentVolume: Double, fullnessOfTheCargoCompartment: FullnessOfTheCargoCompartment, positionTrailer: PositionTrailer) {
        
        self.carBrand = carBrand
        self.yearOfRelease = yearOfRelease
        self.upperHatch = upperHatch
        self.engineActivityStatus = engineActivityStatus
        self.windowPosition = windowPosition
        self.hoodPosition = hoodPosition
        self.cargoCompartmentVolume = cargoCompartmentVolume
        self.fullnessOfTheCargoCompartment = fullnessOfTheCargoCompartment
        self.positionTrailer = positionTrailer
    }
    
    func changeFullnessOfTheCargoCompartment(_ action: FullnessOfTheCargoCompartment) {
        
        fullnessOfTheCargoCompartment = action
    }
    
    func changePositionTrailer(_ action: PositionTrailer) {
        
        positionTrailer = action
        
    }
    
    func changeEngineActivityStatus(_ action: EngineActivityStatus) {
        
        engineActivityStatus = action
        
        switch action {
        case .running:
            print("Автоматическое включение кондиционера")
        case .notRunning:
            print("Автоматическое отключение радиостанции")
        }
    }
}

extension TrunkCar: CustomStringConvertible {
    
    var description: String {
        
        return
"""
 Марка машины - \(carBrand)\n Год выпуска - \(yearOfRelease)\n Наличие люка - \(upperHatch ? "есть" : "нет")\n Состояния двигателя - \(engineActivityStatus.rawValue)\n Состояние окон - \(windowPosition.rawValue)\n Положение капота - \(hoodPosition.rawValue)\n Состояние индикатора положения капота - \(openHoodIndicator.rawValue)\n Объем грузового отсека - \(cargoCompartmentVolume)\n Показатель уровня загрузки грузового отсека - \(fullnessOfTheCargoCompartment.rawValue)\n Положение прицепа - \(positionTrailer.rawValue)\n Максимальная скорость - \(maxSpeed)
"""
    }
}

var myTrunkCarOne = TrunkCar(carBrand: "Ford", yearOfRelease: "2017", upperHatch: true, engineActivityStatus: .notRunning, windowPosition: .opened, hoodPosition: .opened, cargoCompartmentVolume: 80_000, fullnessOfTheCargoCompartment: .emptyCargoCompartment, positionTrailer: .disconnected)

//--- загрузка и разгрузка грузового отсека
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt25Per)
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt50Per)
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt75Per)
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt25Per)

print(myTrunkCarOne)

var myTrunkCarTwo = TrunkCar(carBrand: "Hyundai", yearOfRelease: "2003", upperHatch: false, engineActivityStatus: .running, windowPosition: .opened, hoodPosition: .closed, cargoCompartmentVolume: 75_000, fullnessOfTheCargoCompartment: .filledInAt50Per, positionTrailer: .disconnected)

//--- соединение с прицепом
myTrunkCarTwo.changePositionTrailer(.connected)

//--- запуск двигателя
myTrunkCarOne.changeEngineActivityStatus(.running)

print(myTrunkCarTwo)
