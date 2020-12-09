import { Component, OnInit } from '@angular/core';
import { ConfigService } from '../services/config.service';

@Component({
  selector: 'app-menu',
  templateUrl: './menu.component.html'
})
export class MenuComponent implements OnInit {

  public menu; 
  public test : String = "testing new docker script";

  constructor(private configService: ConfigService) { 
  }

  ngOnInit() {
    this.menu = this.configService.getMenu()
  }

}
