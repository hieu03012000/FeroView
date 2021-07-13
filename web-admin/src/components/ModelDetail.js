import React from 'react';
import { useParams, useRouteMatch, Link } from 'react-router-dom';
import Lightbox from "react-awesome-lightbox";
import ModelService from '../services/ModelService';
import CollectionImageService from '../services/CollectionImageService';
import ImageService from '../services/ImageService';
import "react-awesome-lightbox/build/style.css";

export default function ModelDetail(props) {
  const { url } = useRouteMatch();
  const { id } = useParams();
  return (
    <_ModelDetail modelId={id} url={url} {...props} />
  );
}

class _ModelDetail extends React.Component {

  constructor(props) {
    super(props);
    this.state = { model: undefined, isShown: false };
  }

  componentDidMount() {
    this.loadData();
  }

  loadData = async () => {
    const modelService = new ModelService();
    const model = await modelService.getById(this.props.modelId);
    const collectionService = new CollectionImageService();
    const collection = await collectionService.get(this.props.modelId);
    const imgs = [];
    const imageService = new ImageService();
    for (let col of collection.data) {
      if (col.gif) {
        imgs.push([{url: col.gif, title: col.name}]);
      } else {
        const { data } = await imageService.get(col.id);
        imgs.push(data.map(img => { return { url: img.fileName, title: col.name }; }));
      }
    }
    console.log(imgs);
    this.setState({ model: model.data, collection: collection.data, imgs });
  }

  showLightBox = (collectionIndex, imgIndex) => {
    this.props.setZIndex(1);
    this.setState({isShown: true, collectionIndex, imgIndex});
  }

  closseLightBox = () => {
    this.props.setZIndex(3);
    this.setState({isShown: false});
  }

  render() {
    if (!this.state.model) {
      return <div />;
    }
    return (
      <div className="profile-flex">
        <div className="profile-left">
          <div className="model-avatar">
            <img src={this.state.model.avatar ? this.state.model.avatar : 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/1024px-User-avatar.svg.png'} alt="Model Avatar" />
          </div>
          <div className="model-detail">
            <div className="title-section">Details</div>
            <div className="detail-item">
              <span className="detail-item-part part-left text-capitalize">Date Of Birth</span>
              <span className="detail-item-part part-right">{new Date(this.state.model.dateOfBirth).toDateString()}</span>
            </div>
            {
              this.state.model.bodyPart.map(part => (
                <div className="detail-item" key={part.bodyPartTypeId}>
                  <span className="detail-item-part part-left text-capitalize">{part.bodyPartTypeName}</span>
                  <span className="detail-item-part part-right">
                    {part.bodyAttribute.length > 0
                      ? part.bodyAttribute.map(bodyAtt => (
                        bodyAtt.value + " " + bodyAtt.measure + "; "
                      ))
                      : ''
                    }
                  </span>
                </div>
              ))
            }
          </div>
          <div className="model-detail">
            <div className="title-section">Product Links</div>
            {
              this.state.model.product.lenght === 0
                ? 'Empty'
                : <ul className="m-l-40">
                  {this.state.model.product.map((product, index) => (
                    <li key={index}>{product.link}</li>
                  ))
                  }
                </ul>
            }
          </div>
          <div className="btn-task">
            <Link to={this.props.url + '/calendar'}>
              <button type="button" className="btn btn-outline-primary btn-block">Task Schedule</button>
            </Link>
          </div>
        </div>
        <div className="profile-right">
          <div className="model-detail">
            <div className="title-section">{this.state.model.name}</div>
            <div className="detail-item m-t-20">
              <span className="detail-item-part"><b>Status:</b> <span className="text-uppercase">{this.state.model.status === 1 ? 'Active' : this.state.model.status === 2 ? 'Inactive' : 'Pending'}</span></span>
            </div>
            <div className="detail-item">
              <span className="detail-item-part"><b>Gender:</b> {this.state.model.gender === 0 ? 'Others' : this.state.model.gender === 1 ? 'Female' : 'Male'}</span>
              <span className="detail-item-part"><b>Email:</b> {this.state.model.username}</span>
            </div>
            <div className="detail-item m-t-20">
              <span className="detail-item-part"><b>Phone:</b> {this.state.model.phone}</span>
              <span className="detail-item-part"><b>Address:</b> {this.state.model.subAddress}</span>
            </div>
            <div className="m-t-20">
              <div className="m-b-10"><b>Styles</b></div>
              {
                this.state.model.modelStyle.map(style => (
                  <span key={style.styleId} className="chip">{style.styleName}</span>
                ))
              }
            </div>
            <div className="m-t-20">
              <b>About Me</b>
              <p className="text-justify">{this.state.model.gifted}</p>
            </div>
          </div>
          <div className="model-collection">
            <div className="title-section">Image Collection</div>
            <ul className="nav nav-tabs" id="myTab" role="tablist">
              {
                this.state.collection.map((collection, index) => (
                  <li className="nav-item" key={index}>
                    <a className={`nav-item nav-link${index === 0 ? " active" : ""}`}
                      id={`nav-${collection.id}-tab`} data-toggle="tab" 
                      href={`#nav-${collection.id}`} role="tab" 
                      aria-controls={`nav-${collection.id}`} aria-selected="true"
                    >{collection.name}</a>
                  </li>
                ))
              }
            </ul>
            <div className="tab-content" id="myTabContent">
              {
                this.state.imgs.map((imgs, index) => (
                  <div key={`collection-${index}`} className={`tab-pane fade${index === 0 ? " show active" : ""}`}
                    id={`nav-${this.state.collection[index].id}`} 
                    role="tabpanel" 
                    aria-labelledby={`nav-${this.state.collection[index].id}-tab`}
                  >
                    <div className="img-section">
                      <ul>
                        {
                          imgs
                            ? imgs.map((img, imgIndex) => (
                              <li key={`img-${index}-${imgIndex}`}>
                                <img src={img.url} alt="Model Image" onClick={() => this.showLightBox(index, imgIndex)}/>
                              </li>
                            ))
                            : <div />
                        }
                      </ul>
                    </div>
                  </div>
                ))
              }
            </div>
          </div>
        </div>
        {
          this.state.isShown && this.state.imgs[this.state.collectionIndex].length === 1
          ? <Lightbox image={this.state.imgs[this.state.collectionIndex][0].url} onClose={this.closseLightBox} title={this.state.collection[this.state.collectionIndex].name} />
          : this.state.isShown && this.state.imgs[this.state.collectionIndex].length > 1
          ? <Lightbox images={this.state.imgs[this.state.collectionIndex]} startIndex={this.state.imgIndex} onClose={this.closseLightBox} />
          : <div />
        } 
      </div>
    );
  }
}
