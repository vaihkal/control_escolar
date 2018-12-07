import { Component } from '@angular/core';
import { NavController, NavParams } from 'ionic-angular';

/**
 * Generated class for the AttendanceListPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@Component({
  selector: 'page-attendance-list',
  templateUrl: 'attendance-list.html',
})
export class AttendanceListPage {
  public materia: any;
  public lista: any[] = [];

  constructor(public navCtrl: NavController, public navParams: NavParams) {
    this.materia = navParams.get("materia");
    this.generateAttendance();
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad AttendanceListPage');
  }
  generateAttendance(){
    var hoy = new Date();
    for (let index = 0; index < this.materia.asistencias + this.materia.faltas; index++) {
      let o = hoy.setDate(hoy.getDate() - index);
      this.lista.push({dia: o, asistencia: 1});
    }
  }

}
