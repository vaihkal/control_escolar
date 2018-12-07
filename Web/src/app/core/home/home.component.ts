import { Component } from '@angular/core';
import { map } from 'rxjs/operators';
import { Breakpoints, BreakpointState, BreakpointObserver } from '@angular/cdk/layout';

@Component({
  selector: 'app-core/home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  /** Based on the screen size, switch from standard to one column per row */
  cards = this.breakpointObserver.observe(Breakpoints.Handset).pipe(
    map(({ matches }) => {
      if (matches) {
        return [
          { title: 'Materias', cols: 1, rows: 1 },
          { title: 'Notificaciones y Mensajes', cols: 1, rows: 1 },
          { title: 'Calendario', cols: 1, rows: 1 }
        ];
      }

      return [
        { title: 'Materias', cols: 2, rows: 1 },
        { title: 'Notificaciones y Mensajes', cols: 1, rows: 1 },
        { title: 'Calendario', cols: 1, rows: 1 }
      ];
    })
  );

  constructor(private breakpointObserver: BreakpointObserver) {}
}
