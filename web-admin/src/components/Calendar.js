import * as React from 'react';
import Paper from '@material-ui/core/Paper';
import { ViewState } from '@devexpress/dx-react-scheduler';
import {
  Scheduler,
  WeekView,
  Appointments,
  Toolbar,
  ViewSwitcher,
  MonthView,
  DayView,
  DateNavigator,
  TodayButton
} from '@devexpress/dx-react-scheduler-material-ui';
import { useParams } from "react-router-dom";
import ModelService from '../services/ModelService';  

export default function Calendar() {
  const { id } = useParams();
  return (
    <_Calendar modelId={id}/>
  );
}

class _Calendar extends React.PureComponent {
  constructor(props) {
    super(props);

    this.state = {
      data: [],
      currentViewName: 'work-week',
    };
    this.currentViewNameChange = (currentViewName) => {
      this.setState({ currentViewName });
    };
  }

  componentDidMount() {
    this.loadData();
  }

  loadData = async () => {
    const modelService = new ModelService();
    const { data } = await modelService.getTasks(this.props.modelId);
    const appointments = data.map(task => {
      return {
        title: task.castingName,
        startDate: new Date(task.startAt),
        endDate: new Date(task.endAt)
      }
    });
    this.setState({ data: appointments })
  }

  render() {
    const { data, currentViewName } = this.state;
    return (
      <div>
        <div className="row">
          <div className="col-md-12">
            <div className="overview-wrap">
              <h2 className="title-1 m-b-30">Task Schedule</h2>
            </div>
          </div>
        </div>
        <Paper>
          <Scheduler data={data} height={500}>
            <ViewState
              defaultCurrentDate={ new Date().toDateString() }
              currentViewName={currentViewName}
              onCurrentViewNameChange={this.currentViewNameChange}
            />
            <WeekView startDayHour={10} endDayHour={19} />
            <WeekView
              name="work-week"
              displayName="Work Week"
              excludedDays={[0, 6]}
              startDayHour={10}
              endDayHour={19}
            />
            <MonthView />
            <DayView />
            <Toolbar />
            <DateNavigator />
            <TodayButton />
            <ViewSwitcher />
            <Appointments />
          </Scheduler>
        </Paper>
      </div>
    );
  }
}
