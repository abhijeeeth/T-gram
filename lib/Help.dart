import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildFAQItem(
            "What is TIGRAM?",
            "TIGRAM is a web-based application and mobile application developed for private forest owners to apply for transit passes for exempted species of trees and NOC for non-exempted species.",
          ),
          _buildFAQItem(
            "What is a transit pass?",
            "A transit pass is a pass issued by the forest department for intra-state transit or transportation of timber for non-exempted species as per the Forest Act.\n\nList of non-exempted species:\n- Rosewood (Dalbergia latifolia)\n- Teak (Tectona grandis)\n- Thempavu (Terminalia tomentosa)\n- Kampakam (Hopea Parviflora)\n- Chadachi (Grewia tiliifolia)\n- Chandana vempu (Cedrela toona)\n- Vellakil (Dysoxylum malabaricum)\n- Irul (Xylia xylocarpa)\n- Ebony (Diospyrus sp.)",
          ),
          _buildFAQItem(
            "When one can apply for Transit pass?",
            "An applicant can apply for a transit pass only after the Revenue Department approves the application.",
          ),
          _buildFAQItem(
            "How Timber Transit Pass System works?",
            "An applicant has to register in the system. Thereafter, the applicant can apply for a transit pass. The application will move to concerned officers. After verification, the Transit Pass will be issued. The applicant can later download the transit pass from the 'Check Pass Status' option.",
          ),
          _buildFAQItem(
            "How to register on the website?",
            "The applicant can click on the 'Register' button on the home page of the website. They need to enter personal details like name, email ID, password, mobile number, and ID proof in the registration form. Accepted ID proofs include:\n- Aadhar card\n- Driving License\n- Passport\n- Government ID\n- Voter Identity Card",
          ),
          _buildFAQItem(
            "What credentials are required to login into the system?",
            "The applicant can login by entering the registered email address and the password which was set during registration.",
          ),
          _buildFAQItem(
            "What are document required for transit pass?",
            "Following is the list of documents required while applying for a transit pass:\n- Revenue Application document\n- Revenue Approval document\n- Declaration document\n- Tree Ownership Proof\n- Location Sketch\n- Identity Proof",
          ),
          _buildFAQItem(
            "Is there any validity of Transit Pass?",
            "A transit pass will be available for download from TIGRAM application for 7 days after the application is approved by the forest range officer.",
          ),
          _buildFAQItem(
            "Can I take a printout of my online transit pass?",
            "Yes, you can take the print of your online transit pass. You can click on the download button link in 'Check Pass Status' to download the transit pass and print the same.",
          ),
          _buildFAQItem(
            "Can the officer change the applicant details or edit the form after submitting the online form?",
            "The officer can change only the wood log details by editing the form during or after the verification/field inspection is carried out.",
          ),
          _buildFAQItem(
            "How do I track my transit pass once I have applied?",
            "The applicant can track the transit pass by clicking on the 'Check Pass Status' option which is seen on the user dashboard once the applicant logs in successfully.",
          ),
          _buildFAQItem(
            "Can a single Transit Pass be generated or used for exempted and non-exempted species?",
            "No. For exempted species, NOC (No Objection Certificate) will be generated based on the application made by the applicant using the 'Download NOC' link, and for non-exempted species, a transit pass is generated.",
          ),
          _buildFAQItem(
            "When one can apply for No Objection Certificate?",
            "If an applicant wants to transport a species which is exempted as per Forest Act and which does not require a transit pass, but still as per Forest Department rule transit of such timber will require an applicant to apply for NOC for hassle-free movement.",
          ),
          _buildFAQItem(
            "What are documents required for No Objection Certificate?",
            "A valid photo identity card (Aadhar card/Passport/Voter ID/Driving License/Government ID) is required along with details of exempted timber species to be transited, while applying for NOC.",
          ),
          _buildFAQItem(
            "Can I apply for transit pass before or after the felling of the tree?",
            "The applicant can apply for transit in both cases, before and even after the felling of the trees on TIGRAM application.",
          ),
          _buildFAQItem(
            "How to set my password if I forgot my password?",
            "To reset password, the applicant can click on 'Forgot password' link on the user login page. The applicant will be redirected to 'Change Password' page, where they can enter email address or mobile number used during registration and then click on 'SEND OTP' button. After verification of OTP, enter a new password for login and then click on 'SAVE' button. The applicant can then login with the new password.",
          ),
          _buildFAQItem(
            "When one can enter the vehicle details? Is it mandatory to enter vehicle details?",
            "The applicant can select the radio button 'Yes' to enter the vehicle details while submitting an application. The applicant can enter vehicle registration number, name of the driver, mobile phone number of the driver, mode of transportation, and attach an image of the license copy. No, it is not mandatory to enter vehicle details.",
          ),
          _buildFAQItem(
            "On what Android version of mobile phone the TIGRAM application can be installed?",
            "The TIGRAM application can be installed on Android version 6 to Android version 11 on the mobile phone.",
          ),
          _buildFAQItem(
            "What is deemed approved application?",
            "The application after being approved by the revenue department, if not approved by the forest officer, will be automatically approved by the system i.e., deemed approved after 20 days.",
          ),
          _buildFAQItem(
            "From where can I download my Transit Pass?",
            "The applicant can login and click on 'Check Pass Status' option and scroll to 'Download TP' column and click on 'Download' link to download the transit pass.",
          ),
          _buildFAQItem(
            "What are the exempted species for which NOC is issued?",
            "Following is the list of exempted species for which NOC is issued:\n1. Coconut\n2. Rubber\n3. Cashew\n4. Tamarind\n5. Mango\n6. Jack Fruit Tree\n7. Kodampuli\n8. Matti\n9. Arecanut\n10. Konna\n11. Seema Konna\n12. Nelli\n13. Neem\n14. Murukku\n15. Jathi\n16. Albezia\n17. Silk Cotton\n18. Acacia auraculiformis\n19. Mangium\n20. Anhili\n21. Kilimaram\n22. Manchadimaram\n23. Vatta\n24. Palm tree\n25. Aranamaram\n26. Eucalyptus\n27. Seemaplavu\n28. Paala",
          ),
          _buildFAQItem(
            "From where can I download my NOC?",
            "The applicant can login and click on 'Check Pass Status' option and scroll to 'Download NOC' column and click on 'Download' link to download the NOC.",
          ),
          _buildFAQItem(
            "How to enter wood log details? Is it mandatory to enter wood log details?",
            "The applicant can click on the 'Yes' button after the question 'Would you like to enter log Details?' and enter the length, girth, and click on the location icon to set the latitude and longitude of the wood log. The volume of the log is automatically calculated by the system. No, it is not mandatory to enter the wood log details.",
          ),
          _buildFAQItem(
            "How to enter the latitude and longitude of the tree?",
            "The applicant can click on the location icon to set the latitude and longitude of the wood log. After the location icon is clicked, the applicant will be directed to a map where they can zoom in or pan to set the latitude and longitude of the trees. There is a marker on the map which will display the location of the trees.",
          ),
          _buildFAQItem(
            "How to exit from the application?",
            "The applicant can click on the logout button which is placed on the top right corner of the website and can tap on the three-lined icon on the mobile application and click on 'Log out' option in the left side menu bar on the mobile application.",
          ),
          _buildFAQItem(
            "In what formats the documents and proofs be attached on TIGRAM?",
            "The images of the document in .jpg, .jpeg, and .png format can be attached on TIGRAM.",
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
