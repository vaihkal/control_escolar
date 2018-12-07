import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import { AttendanceListPage } from '../attendance-list/attendance-list';

@Component({
  selector: 'page-home',
  templateUrl: 'home.html'
})
export class HomePage {

  public materias = [
    {name: "Inglés 1", schedule: "9:00", teacher: "Alonso Pérez", asistencias: 14, faltas: 2 },
    {name: "Álgebra", schedule: "11:00", teacher: "Esteban Ramírez", asistencias: 25, faltas: 4 },
    {name: "Artes", schedule: "12:00", teacher: "Sofía Aguilar", asistencias: 16, faltas: 0},
    {name: "Historia de México", schedule: "13:00", teacher: "María de la Rosa", asistencias: 18, faltas: 1 }
  ]

  constructor(public navCtrl: NavController) {

  }

  openList(materia){
    this.navCtrl.push(AttendanceListPage, {materia: materia});
  }

}
