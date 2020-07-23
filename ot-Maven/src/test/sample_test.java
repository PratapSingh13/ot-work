[TestClass]
    public class sample_test
    {
        [TestMethod]
        public void PalindromeDetector_DetectsPalindrome()
        {
            //Arrange
            var detector = new PalindromeDetector();
            var input = "madamimadam";

            //Act
            var output = detector.IsPalindrome(input);

            //Assert
            Assert.IsTrue(output);
        }

        [TestMethod]
        public void PalindromeDetector_DetectsNonPalindrome()
        {
            var detector = new PalindromeDetector();
            Assert.IsFalse(detector.IsPalindrome("not a palindrome"));
        }
    }
