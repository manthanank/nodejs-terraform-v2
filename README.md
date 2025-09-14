# Node.js Todo API with AWS Infrastructure

A full-stack Todo application built with Node.js, Express, MongoDB, and deployed on AWS using Terraform. This project demonstrates a complete CI/CD pipeline with containerized deployment on AWS ECS.

## 🚀 Features

- **RESTful API** for Todo management (CRUD operations)
- **MongoDB** integration with Mongoose ODM
- **Docker** containerization
- **AWS Infrastructure** managed with Terraform
- **ECS Fargate** for serverless container deployment
- **Application Load Balancer** for high availability
- **ECR** for container image storage
- **VPC** with public/private subnets
- **Security groups** and IAM roles
- **CloudWatch** logging

## 📋 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Health check |
| GET | `/api/todos` | Get all todos |
| POST | `/api/todos` | Create a new todo |
| GET | `/api/todos/:id` | Get todo by ID |
| PUT | `/api/todos/:id` | Update todo by ID |
| DELETE | `/api/todos/:id` | Delete todo by ID |

### Todo Schema

```json
{
  "title": "string (required)",
  "description": "string (optional)",
  "completed": "boolean (default: false)",
  "createdAt": "date (auto-generated)"
}
```

## 🛠️ Tech Stack

### Backend

- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **MongoDB** - Database
- **Mongoose** - ODM for MongoDB
- **CORS** - Cross-origin resource sharing
- **dotenv** - Environment variable management

### Infrastructure

- **Terraform** - Infrastructure as Code
- **AWS ECS Fargate** - Container orchestration
- **AWS ECR** - Container registry
- **AWS VPC** - Virtual private cloud
- **AWS ALB** - Application load balancer
- **AWS CloudWatch** - Logging and monitoring

### DevOps

- **Docker** - Containerization
- **AWS IAM** - Identity and access management
- **AWS Secrets Manager** - Secure credential storage

## 📁 Project Structure

```tree
nodejs-terraform/
├── config/
│   └── db.js                 # Database connection configuration
├── controllers/
│   └── todoController.js     # Todo business logic
├── middlewares/
│   └── errorHandler.js       # Error handling middleware
├── models/
│   └── Todo.js              # Todo data model
├── routes/
│   └── todoRoutes.js        # API routes
├── terraform/
│   ├── ecr.tf              # ECR repository configuration
│   ├── ecs.tf              # ECS cluster and service
│   ├── iam.tf              # IAM roles and policies
│   ├── logs.tf             # CloudWatch logs
│   ├── outputs.tf          # Terraform outputs
│   ├── provider.tf         # AWS provider configuration
│   ├── secrets.tf          # Secrets Manager
│   ├── security.tf         # Security groups
│   ├── variables.tf        # Input variables
│   └── vpc.tf              # VPC and networking
├── Dockerfile              # Container configuration
├── package.json            # Node.js dependencies
└── server.js               # Application entry point
```

## 🚀 Quick Start

### Prerequisites

- Node.js (v18 or higher)
- Docker
- AWS CLI configured
- Terraform (v1.0 or higher)
- MongoDB Atlas account or local MongoDB instance

### Local Development

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd nodejs-terraform
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Set up environment variables**

   ```bash
   cp .env.example .env
   ```

   Update `.env` with your MongoDB connection string:

   ```env
   MONGO_URI=mongodb://localhost:27017/node-terraform
   PORT=5000
   ```

4. **Start the development server**

   ```bash
   npm run dev
   ```

5. **Test the API**

   ```bash
   curl http://localhost:5000
   ```

### Docker Deployment

1. **Build the Docker image**

   ```bash
   docker build -t nodejs-todo-api .
   ```

2. **Run the container**

   ```bash
   docker run -p 5000:5000 -e MONGO_URI=your_mongodb_uri nodejs-todo-api
   ```

## ☁️ AWS Deployment with Terraform

### AWS Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed
- Docker image pushed to ECR

### Deploy Infrastructure

1. **Navigate to Terraform directory**

   ```bash
   cd terraform
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Review the plan**

   ```bash
   terraform plan
   ```

4. **Apply the configuration**

   ```bash
   terraform apply
   ```

5. **Get the application URL**

   ```bash
   terraform output alb_dns
   ```

### Environment Variables

Set the following variables in `terraform/variables.tf` or via command line:

```bash
terraform apply -var="mongo_uri=your_mongodb_atlas_uri"
```

Available variables:

- `aws_region`: AWS region (default: ap-south-1)
- `project`: Project name (default: node-crud-app)
- `app_port`: Application port (default: 5000)
- `image_tag`: Docker image tag (default: v1)
- `vpc_cidr`: VPC CIDR block (default: 10.0.0.0/16)
- `mongo_uri`: MongoDB connection string

## 🔧 Configuration

### Database Configuration

The application uses MongoDB for data persistence. Update the connection string in your environment variables:

```javascript
// config/db.js
const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI);
    console.log('MongoDB connected');
  } catch (error) {
    console.error('Database connection error:', error);
    process.exit(1);
  }
};
```

### Error Handling

The application includes centralized error handling:

```javascript
// middlewares/errorHandler.js
const errorHandler = (err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Something went wrong!' });
};
```

## 📊 Monitoring and Logs

- **CloudWatch Logs**: Application logs are automatically sent to CloudWatch
- **Health Checks**: Built-in health check endpoint at `/`
- **Error Tracking**: Centralized error handling and logging

## 🔒 Security Features

- **CORS** enabled for cross-origin requests
- **Security Groups** configured for network access control
- **IAM Roles** with least privilege access
- **Secrets Manager** for sensitive data storage
- **VPC** with private subnets for enhanced security

## 🧪 Testing

Test the API endpoints using curl or any HTTP client:

```bash
# Health check
curl http://your-alb-dns/

# Create a todo
curl -X POST http://your-alb-dns/api/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "Learn Terraform", "description": "Complete Terraform tutorial"}'

# Get all todos
curl http://your-alb-dns/api/todos

# Update a todo
curl -X PUT http://your-alb-dns/api/todos/{id} \
  -H "Content-Type: application/json" \
  -d '{"completed": true}'

# Delete a todo
curl -X DELETE http://your-alb-dns/api/todos/{id}
```

## 🚀 Deployment Pipeline

1. **Code Changes**: Push changes to your repository
2. **Build**: Docker image is built with new changes
3. **Push**: Image is pushed to ECR
4. **Deploy**: ECS service is updated with new image
5. **Health Check**: ALB performs health checks on new instances

## 📝 Scripts

- `npm start`: Start the production server
- `npm run dev`: Start development server with nodemon
- `npm test`: Run tests (currently not implemented)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the ISC License.

## 🆘 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Verify MongoDB URI is correct
   - Check network connectivity
   - Ensure MongoDB service is running

2. **Terraform Apply Fails**
   - Verify AWS credentials are configured
   - Check IAM permissions
   - Ensure all required resources are available in the region

3. **ECS Service Won't Start**
   - Check CloudWatch logs for errors
   - Verify container image exists in ECR
   - Check security group configurations

### Support

For issues and questions, please create an issue in the repository or contact the development team.

---

## Happy Coding! 🎉
