import React from 'react';
import ModelService from '../services/ModelService';
import { Link, useRouteMatch } from 'react-router-dom';

export default function Dashboard() {
  let { url } = useRouteMatch();
  return (
    <_Dashboard url={ url } />
  );
}

class _Dashboard extends React.Component {

  constructor(props) {
    super(props);
    this.state = { models: [] };
  }

  componentDidMount() {
    this.loadData();
  }

  loadData = async () => {
    const modelService = new ModelService();
    const { data } = await modelService.get();
    this.setState({ models: data });
  }

  onPressActive = async (modelId) => {
    const modelService = new ModelService();
    await modelService.updateStatus(modelId, 1);
    this.loadData();
  }

  onPressInactive = async (modelId) => {
    const modelService = new ModelService();
    await modelService.updateStatus(modelId, 2);
    this.loadData();
  }

  render() {
    return (
      <div>
        <div className="row">
          <div className="col-md-12">
            <div className="overview-wrap">
              <h2 className="title-1">Recent Model</h2>
            </div>
          </div>
        </div>
        <div className="table-responsive table--no-card m-t-25 m-b-30">
          <table className="table table-borderless table-striped table-data3">
            <thead>
              <tr>
                <th>model ID</th>
                <th>name</th>
                <th>gender</th>
                <th>phone</th>
                <th>address</th>
                <th>status</th>
                <th className="text-center">action</th>
              </tr>
            </thead>
            <tbody>
              {
                this.state.models.reverse().map((model, index) => (
                  <tr key={ model.id }>
                    <td><Link to={ this.props.url + '/model/' + model.id  }>{ model.id }</Link></td>
                    <td>{ model.name }</td>
                    <td>{ model.gender === 0 ? 'Others' : model.gender === 1 ? 'Female' : 'Male' }</td>
                    <td>{ model.phone }</td>
                    <td>{ model.subAddress }</td>
                    <td>{ model.status === 1 ? 'Active' : model.status === 2 ? 'Inactive' : 'Pending' }</td>
                    {
                      model.status === 1
                      ? <td className="text-center">
                        <button class="btn btn-outline-secondary btn-sm" 
                          type="submit"
                          onClick={ () => this.onPressInactive(model.id) }
                        >Inactive</button>
                      </td>
                      : model.status === 2
                      ? <td className="text-center">
                        <button class="btn btn-outline-primary btn-sm"
                          type="submit"
                          onClick={ () => this.onPressActive(model.id) }
                        >Active</button>
                      </td>
                      : <td>
                        <button class="btn btn-outline-primary btn-sm m-r-5"
                          type="submit"
                          onClick={ () => this.onPressActive(model.id) }
                        >Approve</button>
                        <button class="btn btn-outline-secondary btn-sm"
                          type="submit"
                          onClick={ () => this.onPressInactive(model.id) }
                        >Reject</button>
                      </td>
                    }
                    
                  </tr>
                ))
              }
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}